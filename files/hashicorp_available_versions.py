#!/usr/bin/python
"""This file parses HashiCorp version information"""
import sys
import socket
import re
from urllib2 import URLError, HTTPError
from urllib2 import urlopen
from HTMLParser import HTMLParser
from optparse import OptionParser

VERSION = '0.1'

class HashiCorpVersionParser(HTMLParser):
    """Parses HTML with anchors which contains the versions"""
    parse_version = False
    version_pattern = re.compile('.+_(.+)')
    versions = []

    def handle_starttag(self, tag, attrs):
        if tag == 'a':
            self.parse_version = True

    def handle_endtag(self, tag):
        if tag == 'a':
            self.parse_version = False

    def handle_data(self, data):
        if self.parse_version:
            matched = self.version_pattern.match(data)
            if matched:
                self.versions.append(matched.group(1))

    def get_versions(self):
        """Returns a list of all parsed versions"""
        return self.versions

def arg_parser():
    """Parses command arguments"""
    parser = OptionParser(description='HashiCorp Tools available version fetcher')
    parser.add_option('-u', '--url',
                      type=str,
                      default='https://releases.hashicorp.com',
                      help='Base URL to fetch version data from.')
    parser.add_option('-t', '--tool',
                      type=str,
                      help='Name of the tool.')
    parser.add_option('-r', '--release',
                      type=str,
                      default='latest',
                      help='Released version, all or latest.')
    return parser

def main(parser):
    """Main function"""
    rawdata = None
    data = None
    (options, args) = parser.parse_args()
    if options.url and options.tool:
        try:
            rawdata = urlopen(options.url + '/' + options.tool)
        except socket.error:
            sys.exit(2)
        except HTTPError:
            sys.exit(2)
        except URLError:
            sys.exit(2)
    else:
        parser.print_help()
        sys.exit(1)

    data = rawdata.read()
    version_parser = HashiCorpVersionParser()
    version_parser.feed(data)

    versions = version_parser.get_versions()

    if versions:
        if options.release == 'all':
            for version in versions:
                sys.stdout.write(version + ' ')
        elif options.release == 'latest':
            for version in versions:
                # To exclude beta and rc releases
                if "-" not in version:
                    sys.stdout.write(version)
                    break
        else:
            for version in versions:
                if version.startswith(options.release):
                    sys.stdout.write(version + ' ')
    sys.stdout.flush()

if __name__ == "__main__":
    main(arg_parser())
