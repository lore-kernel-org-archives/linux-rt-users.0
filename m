Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1478BEB64D7
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jun 2023 16:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjFWQB5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 12:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWQB4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jun 2023 12:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D212130
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jun 2023 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687536068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3u310FtnYPdz6UFGr9XcZ/VswjYfAHcEw0QPlJKinQ=;
        b=LN4MvdrS8robf1E4yfLHgVRRp7TLADWY0Q0Q2oygmWhqBiakOyiXbf5x43O6BCugc3A0Xd
        hfDnUQsnZe8PQf7zlc+VUhUbDBHHLsdLvcCMfDGFOSS/wHhuAgUO02o4t03aHxpyQVCAOX
        /ly76+LiYWvB6iMo+uYwSs0l7zi8zfA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-g2BOpnSxPqylD6KrXYFZzg-1; Fri, 23 Jun 2023 12:01:03 -0400
X-MC-Unique: g2BOpnSxPqylD6KrXYFZzg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7654e1f86aeso68328685a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jun 2023 09:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687536063; x=1690128063;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3u310FtnYPdz6UFGr9XcZ/VswjYfAHcEw0QPlJKinQ=;
        b=LnuAYFMiWFxPjzRRnshfG1qvcqlRIuEjSRAmVt//8+Qh+2oTAWQkz24ndDZkPW0So3
         HfU0aJTkNu8POtUIBoLXkX0nyHqKSXZPjOai+Ja5aSQZO9cXvSA9/shBbqtVYe8Clz9X
         T/u2KQY1OPWR8H2nhl8utl+OcWYwGFxgyp/eo5dC3y2Q746TOHR1KoMnLCaYWW5HH48f
         SVe9o5WOsN+0y1pPpVrXeMjh59aE3w7OXgvbKyHTTWdtsSmI1PboIwPoOYy3AX/agDzt
         EbVT1SrOIpndWvQfofVDKEHejd/31QEU8EK9JxIYKLaTJLWPGdt7wEDm3Fc0wczzfgg5
         7/Mg==
X-Gm-Message-State: AC+VfDzv+3lxikh57yIfY0yApd0GJfxdpTY2nvJfIiHr/9VXrTMZWJKw
        cm+bjiRpOERw3ixc3bpb2pcHQcJFBGfVrE1WC+s29I/nG2uS9Y9QMWUAsevF9heMp42Tn8AL1cm
        zlprlBjpXqr0cQ4o0nr0AqeLLBok=
X-Received: by 2002:a05:620a:479b:b0:765:3f8b:2989 with SMTP id dt27-20020a05620a479b00b007653f8b2989mr4338277qkb.47.1687536063321;
        Fri, 23 Jun 2023 09:01:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nh6b/KLMn+WNnylHi5GUxjE1SfvuiS8OvKZrMGqnfTB1eiI0xNqkhl7gd668dgg1rXHqrtg==
X-Received: by 2002:a05:620a:479b:b0:765:3f8b:2989 with SMTP id dt27-20020a05620a479b00b007653f8b2989mr4338195qkb.47.1687536062146;
        Fri, 23 Jun 2023 09:01:02 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id j6-20020a37c246000000b00763bcec87cesm3434310qkm.26.2023.06.23.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 09:01:01 -0700 (PDT)
Date:   Fri, 23 Jun 2023 12:00:17 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH] rteval: Changed files to use argparse library instead
 of optparse
In-Reply-To: <20230622164221.248271-1-ashelat@redhat.com>
Message-ID: <1785842-e26-5e19-aa24-1e65afeef24b@redhat.com>
References: <20230622164221.248271-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 22 Jun 2023, Anubhav Shelat wrote:

> Replaced optparse.OptionParser() with argparse.ArgumentParser() and optparse.add_options() with argparse.add_arguments().
> Added/changed code to assign the cmd_opts and cmd_args variables in rteval-cmd correctly to get the -Z/--summarize and
> -H/--raw-histogram working correctly.
> Note: the rteval/server files haven't been tested since server is
> disabled.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval-cmd                  | 88 ++++++++++++++++++++++---------------
>  rteval/modules/__init__.py  | 12 +++--
>  rteval/rtevalConfig.py      |  4 +-
>  server/rteval_testserver.py | 11 ++---
>  server/unittest.py          |  8 ++--
>  5 files changed, 70 insertions(+), 53 deletions(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index cbba9cd2e451..96854e05f746 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -40,7 +40,7 @@ import os
>  import time
>  import re
>  import shutil
> -import optparse
> +import argparse
>  import tempfile
>  import requests
>  import lxml.etree
> @@ -115,55 +115,55 @@ def parse_options(cfg, parser, cmdargs):
>      # thus they are prefixed with 'rteval___'.
>      # See rteval/rtevalConfig::UpdateFromOptionParser() method for more info
>      #
> -    parser.add_option("-d", "--duration", dest="rteval___duration",
> -                      type="string", default=rtevcfg.duration, metavar="DURATION",
> -                      help="specify length of test run (default: %default)")
> -    parser.add_option("-v", "--verbose", dest="rteval___verbose",
> +    parser.add_argument("-d", "--duration", dest="rteval___duration",
> +                      type=str, default=rtevcfg.duration, metavar="DURATION",
> +                      help=f"specify length of test run (default: {rtevcfg.duration})")
> +    parser.add_argument("-v", "--verbose", dest="rteval___verbose",
>                        action="store_true", default=rtevcfg.verbose,
> -                      help="turn on verbose prints (default: %default)")
> -    parser.add_option("-q", "--quiet", dest="rteval___quiet",
> +                      help=f"turn on verbose prints (default: {rtevcfg.verbose})")
> +    parser.add_argument("-q", "--quiet", dest="rteval___quiet",
>                        action="store_true", default=rtevcfg.quiet,
> -                      help="turn on quiet mode (default: %default)")
> -    parser.add_option("-w", "--workdir", dest="rteval___workdir",
> -                      type="string", default=rtevcfg.workdir, metavar="DIRECTORY",
> -                      help="top directory for rteval data (default: %default)")
> -    parser.add_option("-l", "--loaddir", dest="rteval___srcdir",
> -                      type="string", default=rtevcfg.srcdir, metavar="DIRECTORY",
> -                      help="directory for load source tarballs (default: %default)")
> -    parser.add_option("-i", "--installdir", dest="rteval___installdir",
> -                      type="string", default=rtevcfg.installdir, metavar="DIRECTORY",
> -                      help="place to locate installed templates (default: %default)")
> -    parser.add_option("-s", "--sysreport", dest="rteval___sysreport",
> +                      help=f"turn on quiet mode (default: {rtevcfg.quiet})")
> +    parser.add_argument("-w", "--workdir", dest="rteval___workdir",
> +                      type=str, default=rtevcfg.workdir, metavar="DIRECTORY",
> +                      help=f"top directory for rteval data (default: {rtevcfg.workdir})")
> +    parser.add_argument("-l", "--loaddir", dest="rteval___srcdir",
> +                      type=str, default=rtevcfg.srcdir, metavar="DIRECTORY",
> +                      help=f"directory for load source tarballs (default: {rtevcfg.srcdir})")
> +    parser.add_argument("-i", "--installdir", dest="rteval___installdir",
> +                      type=str, default=rtevcfg.installdir, metavar="DIRECTORY",
> +                      help=f"place to locate installed templates (default: {rtevcfg.installdir})")
> +    parser.add_argument("-s", "--sysreport", dest="rteval___sysreport",
>                        action="store_true", default=rtevcfg.sysreport,
> -                      help='run sysreport to collect system data (default: %default)')
> -    parser.add_option("-D", '--debug', dest='rteval___debugging',
> +                      help=f'run sysreport to collect system data (default: {rtevcfg.sysreport})')
> +    parser.add_argument("-D", '--debug', dest='rteval___debugging',
>                        action='store_true', default=rtevcfg.debugging,
> -                      help='turn on debug prints (default: %default)')
> +                      help=f'turn on debug prints (default: {rtevcfg.debugging})')
>      #parser.add_option("-X", '--xmlrpc-submit', dest='rteval___xmlrpc',
>      #                  action='store', default=rtevcfg.xmlrpc, metavar='HOST',
>      #                  help='Hostname to XML-RPC server to submit reports')
>      #parser.add_option("-P", "--xmlrpc-no-abort", dest="rteval___xmlrpc_noabort",
>      #                  action='store_true', default=False,
>      #                  help="Do not abort if XML-RPC server do not respond to ping request");
> -    parser.add_option("-Z", '--summarize', dest='rteval___summarize',
> +    parser.add_argument("-Z", '--summarize', dest='rteval___summarize',
>                        action='store_true', default=False,
>                        help='summarize an already existing XML report')
> -    parser.add_option("-H", '--raw-histogram', dest='rteval___rawhistogram',
> +    parser.add_argument("-H", '--raw-histogram', dest='rteval___rawhistogram',
>                        action='store_true', default=False,
>                        help='Generate raw histogram data for an already existing XML report')
> -    parser.add_option("-f", "--inifile", dest="rteval___inifile",
> -                      type='string', default=None, metavar="FILE",
> +    parser.add_argument("-f", "--inifile", dest="rteval___inifile",
> +                      type=str, default=None, metavar="FILE",
>                        help="initialization file for configuring loads and behavior")
> -    parser.add_option("-a", "--annotate", dest="rteval___annotate",
> -                      type="string", default=None, metavar="STRING",
> +    parser.add_argument("-a", "--annotate", dest="rteval___annotate",
> +                      type=str, default=None, metavar="STRING",
>                        help="Add a little annotation which is stored in the report")
> -    parser.add_option("-L", "--logging", dest="rteval___logging",
> +    parser.add_argument("-L", "--logging", dest="rteval___logging",
>                        action='store_true', default=False,
>                        help='log the output of the loads in the report directory')
> -    parser.add_option("-O", "--onlyload", dest="rteval___onlyload",
> +    parser.add_argument("-O", "--onlyload", dest="rteval___onlyload",
>                        action='store_true', default=False,
>                        help="only run the loads (don't run measurement threads)")
> -    parser.add_option("-V", "--version", dest="rteval___version",
> +    parser.add_argument("-V", "--version", dest="rteval___version",
>                        action='store_true', default=False,
>                        help='print rteval version and exit')
>      # if the -S/--source-download option doesn't include the version, set version to default
> @@ -177,15 +177,33 @@ def parse_options(cfg, parser, cmdargs):
>              sys.argv.insert(ind+1, ModuleParameters()["source"]["default"].replace(".tar.xz", ""))
>          cmdargs.append(sys.argv[ind+1])
>  
> -    parser.add_option("-S", "--source-download", dest="rteval___srcdownload",
> -                        type="string", default=None, metavar="KERNEL_VERSION",
> +    parser.add_argument("-S", "--source-download", dest="rteval___srcdownload",
> +                        type=str, default=None, metavar="KERNEL_VERSION",
>                          help='download a source kernel from kernel.org and exit (if no version is provided, downloads default kernel)')
>  
>  
>      if not cmdargs:
>          cmdargs = ["--help"]
>  
> -    (cmd_opts, cmd_args) = parser.parse_args(args=cmdargs)
> +    # if -Z/--summarize is specified, add the files to be summarized to cmd_args, and add -Z to cmd_opts
> +    cmd_args = []
> +    if (sys.argv.count('-Z')+sys.argv.count('--summarize')) > 0:
> +        try:
> +            ind = cmdargs.index('-Z')
> +        except ValueError:
> +            ind = cmdargs.index('--summarize')
> +        cmd_args = cmdargs[ind+1:]
> +        cmdargs = cmdargs[:ind+1]
> +    # if -H/--raw-histogram is specified, add the files to be summarized to cmd_args, and add -Z to cmd_opts
> +    elif (sys.argv.count('-H')+sys.argv.count('--raw-histogram')) > 0:
> +        try:
> +            ind = cmdargs.index('-H')
> +        except ValueError:
> +            ind = cmdargs.index('--raw-histogram')
> +        cmd_args = cmdargs[ind+1:]
> +        cmdargs = cmdargs[:ind+1]
> +    cmd_opts = parser.parse_args(args=cmdargs)
> +
>      if cmd_opts.rteval___version:
>          print(f"rteval version {RTEVAL_VERSION}")
>          sys.exit(0)
> @@ -207,7 +225,7 @@ def parse_options(cfg, parser, cmdargs):
>          cmd_opts.rteval___duration = float(v) * mult
>  
>      # Update the config object with the parsed arguments
> -    cfg.UpdateFromOptionParser(parser)
> +    cfg.UpdateFromOptionParser(cmd_opts)
>  
>      return cmd_args
>  
> @@ -277,7 +295,7 @@ if __name__ == '__main__':
>          measuremods = MeasurementModules(config, logger=logger)
>  
>          # parse command line options
> -        parser = optparse.OptionParser()
> +        parser = argparse.ArgumentParser()
>          loadmods.SetupModuleOptions(parser)
>          measuremods.SetupModuleOptions(parser)
>          cmd_args = parse_options(config, parser, sys.argv[1:])
> diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
> index d52dd597186a..253e72abf8aa 100644
> --- a/rteval/modules/__init__.py
> +++ b/rteval/modules/__init__.py
> @@ -25,7 +25,7 @@
>  import time
>  from datetime import datetime
>  import threading
> -import optparse
> +import argparse
>  import libxml2
>  from rteval.Log import Log
>  from rteval.rtevalConfig import rtevalCfgSection
> @@ -294,12 +294,11 @@ the information provided by the module"""
>      def SetupModuleOptions(self, parser, config):
>          """Sets up a separate optptarse OptionGroup per module with its supported parameters"""
>  
> -        grparser = optparse.OptionGroup(parser, "Group Options for %s modules" % self.__modtype)
> -        grparser.add_option('--%s-cpulist' % self.__modtype,
> +        grparser = parser.add_argument_group("Group Options for %s modules" % self.__modtype)
> +        grparser.add_argument('--%s-cpulist' % self.__modtype,
>                              dest='%s___cpulist' % self.__modtype, action='store', default="",
>                              help='CPU list where %s modules will run' % self.__modtype,
>                              metavar='LIST')
> -        parser.add_option_group(grparser)
>  
>          for (modname, mod) in list(self.__modsloaded.items()):
>              opts = mod.ModuleParameters()
> @@ -313,7 +312,7 @@ the information provided by the module"""
>                  # Ignore if a section is not found
>                  cfg = None
>  
> -            grparser = optparse.OptionGroup(parser, "Options for the %s module" % shortmod)
> +            grparser = parser.add_argument_group("Options for the %s module" % shortmod)
>              for (o, s) in list(opts.items()):
>                  descr = 'descr' in s and s['descr'] or ""
>                  metavar = 'metavar' in s and s['metavar'] or None
> @@ -328,14 +327,13 @@ the information provided by the module"""
>                      default = 'default' in s and s['default'] or None
>  
>  
> -                grparser.add_option('--%s-%s' % (shortmod, o),
> +                grparser.add_argument('--%s-%s' % (shortmod, o),
>                                      dest="%s___%s" % (shortmod, o),
>                                      action='store',
>                                      help='%s%s' % (descr,
>                                                     default and ' (default: %s)' % default or ''),
>                                      default=default,
>                                      metavar=metavar)
> -            parser.add_option_group(grparser)
>  
>  
>      def InstantiateModule(self, modname, modcfg, modroot=None):
> diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
> index 41f1a567720f..ec14a13adcd9 100644
> --- a/rteval/rtevalConfig.py
> +++ b/rteval/rtevalConfig.py
> @@ -286,11 +286,11 @@ class rtevalConfig:
>          return self.__config_files.__contains__(fname)
>  
>  
> -    def UpdateFromOptionParser(self, parser):
> +    def UpdateFromOptionParser(self, cmd_opts):
>          "Parse through the command line options and update the appropriate config settings"
>  
>          last_sect = None
> -        for sk, v in sorted(vars(parser.values).items()):
> +        for sk, v in sorted(vars(cmd_opts).items()):
>              # optparse key template: {sectionname}___{key}
>              k = sk.split('___')
>              if k[0] != last_sect:
> diff --git a/server/rteval_testserver.py b/server/rteval_testserver.py
> index 3f0c3c73733c..6cac85bcfe52 100644
> --- a/server/rteval_testserver.py
> +++ b/server/rteval_testserver.py
> @@ -31,6 +31,7 @@ import signal
>  from xmlrpc.server import SimpleXMLRPCServer
>  from xmlrpc.server import SimpleXMLRPCRequestHandler
>  from optparse import OptionParser
> +import argparse
>  
>  import xmlrpc_API1
>  from Logger import Logger
> @@ -110,16 +111,16 @@ rtevalserver = None
>  #
>  
>  if __name__ == '__main__':
> -    parser = OptionParser(version="%prog v0.1")
> +    parser = argparse.ArgumentParser(version="%prog v0.1")
>  
> -    parser.add_option("-L", "--listen", action="store", dest="listen", default=LISTEN,
> +    parser.add_argument("-L", "--listen", action="store", dest="listen", default=LISTEN,
>                        help="Which interface to listen to [default: %default]", metavar="IPADDR")
> -    parser.add_option("-P", "--port", action="store", type="int", dest="port", default=PORT,
> +    parser.add_argument("-P", "--port", action="store", type="int", dest="port", default=PORT,
>                        help="Which port to listen to [default: %default]",  metavar="PORT")
> -    parser.add_option("-l", "--log", action="store", dest="logfile", default=None,
> +    parser.add_argument("-l", "--log", action="store", dest="logfile", default=None,
>                        help="Where to log requests.", metavar="FILE")
>  
> -    (options, args) = parser.parse_args()
> +    options = parser.parse_args()
>  
>      logger = Logger(options.logfile, "RTeval")
>      rtevalserver = RTevald(options, logger)
> diff --git a/server/unittest.py b/server/unittest.py
> index 4d53f46590ce..7dcdef08c098 100644
> --- a/server/unittest.py
> +++ b/server/unittest.py
> @@ -1,5 +1,5 @@
>  import sys, threading, time, signal, libxml2
> -from optparse import OptionParser
> +import argparse
>  from rteval_testserver import RTevald
>  from Logger import Logger
>  
> @@ -14,10 +14,10 @@ class ServerThread(threading.Thread):
>          self.port = port
>          self.log = Logger('unit-test-server.log','rteval-xmlrpc-testsrv')
>  
> -        parser = OptionParser()
> -        parser.add_option("-L", "--listen", action="store", dest="listen", default="127.0.0.1",
> +        parser = argparse.ArgumentParser()
> +        parser.add_argument("-L", "--listen", action="store", dest="listen", default="127.0.0.1",
>                            help="Which interface to listen to [default: %default]", metavar="IPADDR")
> -        parser.add_option("-P", "--port", action="store", type="int", dest="port", default=self.port,
> +        parser.add_argument("-P", "--port", action="store", type="int", dest="port", default=self.port,
>                            help="Which port to listen to [default: %default]",  metavar="PORT")
>  
>          (options, args) = parser.parse_args()
> -- 
> 2.39.3
> 
> 

This patch does not apply cleanly

git am a1.patch
Applying: rteval: Changed files to use argparse library instead of 
optparse
error: patch failed: rteval-cmd:115
error: rteval-cmd: patch does not apply
Patch failed at 0001 rteval: Changed files to use argparse library instead 
of optparse

I suspect you are not building this against upstream, but against your 
local repo.

Remember that 
rteval-cmd: If no kernel version is provided to -S/--source-download, 
download default kernel version

was not accepted upstream, I suspect you are generating a patch that 
applies against the above. 

John

