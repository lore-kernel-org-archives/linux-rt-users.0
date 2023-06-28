Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26B2EB64D7
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 13:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjF1N7U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 09:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232237AbjF1N7L (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 09:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687960701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+lAWbFDc+KnK+ELyOf2UIkb8GQ/nxmHylBoKdsSCBxE=;
        b=A/wTgLeUCSHkmM9kwrV2Do5T1oKab4DZsdAP4EAMtSvMozLJnXhc9RasAuCR/Fz11OkSVP
        UWMWoqEJo8nLK2yYkDu5ogOeZam94CuLvPSStHjkfuTXWLs2qnJB5kcdE5qDfwIdNklyf0
        IIyi1563N4RgZPNi7l34sSZvAll/IoI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-Oi0_0PHaO1OFH_PrjLEo-A-1; Wed, 28 Jun 2023 09:58:19 -0400
X-MC-Unique: Oi0_0PHaO1OFH_PrjLEo-A-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ff27ef7214so68334461cf.2
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 06:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960699; x=1690552699;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lAWbFDc+KnK+ELyOf2UIkb8GQ/nxmHylBoKdsSCBxE=;
        b=WWU7mAKGPkzwgZLMkWije+WO84cmRzSNY/LPb7B7V4W9QbpXgCKojI3BvDY5IZJBa3
         mfPuLuky4YJb5lCCKxbNADVGLSvbkgCgG4rh5qKmDdGcyJhgmRuI4q1+UAKrcW87+9d0
         MX+7TVjvaJFaKkaPQ/UjE51w3siK6ki/Rbvva2PG0flAHL6TWA7QOQhIOhXUNYkdtmFn
         QC1OjsMLZretQ3Ov7Kzoi9v12brr1ZAyx1evGKQE7sVxBDxzY/oG/uc1i+dOWcp0GEPo
         Ppb8skuPWsFiIQ3/ZdC2DpX+U4yOyAvuFMwzYZTQXBxyCMxFNaXreRCuVV0kxLf/LoVL
         vF2Q==
X-Gm-Message-State: AC+VfDzOQp1Qjq3pecSIBhSrldUyDEzegi6oIe1kQzy3uOnw2YflRijz
        ELJn+eMZGtiUoPUI38FZ9DYTBd1VHrELRNyaI0Uk+QdwRlUebry1FwWSaWuOqx3Ca7teyRFha8c
        U1SLj6cCt7aFaLpIzCHdxiDjE7xA=
X-Received: by 2002:a05:622a:5d2:b0:400:8eb6:4bf2 with SMTP id d18-20020a05622a05d200b004008eb64bf2mr18125391qtb.13.1687960699048;
        Wed, 28 Jun 2023 06:58:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5z89bwpvaWyPyguIvHkFTCOnRmwPQ9aYFVDoq7wg9O/UD5eludn6T5AQ/jLJhXkhXzEn9EDw==
X-Received: by 2002:a05:622a:5d2:b0:400:8eb6:4bf2 with SMTP id d18-20020a05622a05d200b004008eb64bf2mr18125372qtb.13.1687960698762;
        Wed, 28 Jun 2023 06:58:18 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id q14-20020ac8450e000000b003fdec95e9c8sm5901664qtn.83.2023.06.28.06.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:58:18 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:58:17 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH v2 2/3] Fixed bug in the --source-download option in
 rteval-cmd
In-Reply-To: <20230623175049.492763-2-ashelat@redhat.com>
Message-ID: <91845522-8fcb-8c28-9953-74e33a500d7@redhat.com>
References: <20230623175049.492763-1-ashelat@redhat.com> <20230623175049.492763-2-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 23 Jun 2023, Anubhav Shelat wrote:

> rteval-cmd: Fixed a bug in rteval-cmd which was causing the -S
> option to throw an error when a kernel version was specified.

What kind of kernel version? How are people reading this who don't know
what problem you are solving supposed to understand this?


> Also edited comments, and removed excess code.

This should be a separate patch, don't throw a bunch of
unrelated things together. Not only is it harder for the maintainer to 
read, but if we have to bisect the commits to find an error it makes
unrelated things are included in one patch.


> __init__.py, rtevalConfig.py: Edited comments and strings for accuracy.
> remove_rtevalrun: Replaced optparse for argparse. Edited
> comments to specify argparse instead of optparse.
> rtevak_testserver.py: deleted excess code
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval-cmd                  | 12 ++++++++++--
>  rteval/modules/__init__.py  |  4 ++--
>  rteval/rtevalConfig.py      |  2 +-
>  server/remove_rtevalrun     | 16 ++++++++--------
>  server/rteval_testserver.py |  1 -
>  5 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index 70996acce626..19efd1d0b296 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -166,7 +166,7 @@ def parse_options(cfg, parser, cmdargs):
>      parser.add_argument("-V", "--version", dest="rteval___version",
>                        action='store_true', default=False,
>                        help='print rteval version and exit')
> -    parser.add_argument("-S", "--source-download", dest="rteval___srcdownload",
> +    parser.add_argument("-S", "--source-download", nargs='*', dest="rteval___srcdownload",
>                          type=str, default=None, metavar="KERNEL_VERSION",
>                          help='download a source kernel from kernel.org and exit')
>  
> @@ -183,7 +183,7 @@ def parse_options(cfg, parser, cmdargs):
>              ind = cmdargs.index('--summarize')
>          cmd_args = cmdargs[ind+1:]
>          cmdargs = cmdargs[:ind+1]
> -    # if -H/--raw-histogram is specified, add the files to be summarized to cmd_args, and add -Z to cmd_opts
> +    # if -H/--raw-histogram is specified, add the files to be summarized to cmd_args, and add -H to cmd_opts
>      elif (sys.argv.count('-H')+sys.argv.count('--raw-histogram')) > 0:
>          try:
>              ind = cmdargs.index('-H')
> @@ -191,8 +191,16 @@ def parse_options(cfg, parser, cmdargs):
>              ind = cmdargs.index('--raw-histogram')
>          cmd_args = cmdargs[ind+1:]
>          cmdargs = cmdargs[:ind+1]
> +
>      cmd_opts = parser.parse_args(args=cmdargs)
>  
> +    # if no kernel version was provided for --source-download, set version to default
> +    if (sys.argv.count('-S')+sys.argv.count('--source-download')) > 0:
> +        if cmd_opts.rteval___srcdownload == []:
> +            cmd_opts.rteval___srcdownload = ModuleParameters()["source"]["default"].replace(".tar.xz", "")
> +        else:
> +            cmd_opts.rteval___srcdownload = cmd_opts.rteval___srcdownload[0]
> +
>      if cmd_opts.rteval___version:
>          print(f"rteval version {RTEVAL_VERSION}")
>          sys.exit(0)
> diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
> index 253e72abf8aa..e32d6fd9545d 100644
> --- a/rteval/modules/__init__.py
> +++ b/rteval/modules/__init__.py
> @@ -292,7 +292,7 @@ the information provided by the module"""
>  
>  
>      def SetupModuleOptions(self, parser, config):
> -        """Sets up a separate optptarse OptionGroup per module with its supported parameters"""
> +        """Sets up a separate argparse ArgumentGroup per module with its supported parameters"""
>  
>          grparser = parser.add_argument_group("Group Options for %s modules" % self.__modtype)
>          grparser.add_argument('--%s-cpulist' % self.__modtype,
> @@ -451,7 +451,7 @@ class RtEvalModules:
>          return self.__modules.GetModulesList()
>  
>      def SetupModuleOptions(self, parser):
> -        "Sets up optparse based option groups for the loaded modules"
> +        "Sets up argparse based option groups for the loaded modules"
>          return self.__modules.SetupModuleOptions(parser, self._cfg)
>  
>      def GetNamedModuleObject(self, modname):
> diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
> index ec14a13adcd9..d0115a052324 100644
> --- a/rteval/rtevalConfig.py
> +++ b/rteval/rtevalConfig.py
> @@ -291,7 +291,7 @@ class rtevalConfig:
>  
>          last_sect = None
>          for sk, v in sorted(vars(cmd_opts).items()):
> -            # optparse key template: {sectionname}___{key}
> +            # argparse key template: {sectionname}___{key}
>              k = sk.split('___')
>              if k[0] != last_sect:
>                  # If the section name changed, retrieve the section variables
> diff --git a/server/remove_rtevalrun b/server/remove_rtevalrun
> index cee699e27c9f..7d83f71ea644 100755
> --- a/server/remove_rtevalrun
> +++ b/server/remove_rtevalrun
> @@ -29,7 +29,7 @@
>  
>  import sys
>  import getpass
> -from optparse import OptionParser
> +from argparse import ArgumentParser
>  from database import Database
>  
>  def do_delete(dbc, table, rterid):
> @@ -45,20 +45,20 @@ def do_delete(dbc, table, rterid):
>  
>  
>  if __name__ == '__main__':
> -    parser = OptionParser(version="%prog v0.1")
> +    parser = ArgumentParser(version="%prog v0.1")
>  
> -    parser.add_option("-H", "--host", action="store", dest="dbhost", default="localhost",
> +    parser.add_argument("-H", "--host", action="store", dest="dbhost", default="localhost",
>                        help="Database server to connect to (default: %default)",
>                        metavar="HOST")
> -    parser.add_option("-p", "--port", action="store", dest="dbport", default="5432",
> +    parser.add_argument("-p", "--port", action="store", dest="dbport", default="5432",
>                        help="Database server port to use (default: %default)", metavar="PORT")
> -    parser.add_option("-U", "--user", action="store", dest="dbuser", default="rtevaladmin",
> +    parser.add_argument("-U", "--user", action="store", dest="dbuser", default="rtevaladmin",
>                        help="Database user to connect as (default: %default)", metavar="USERNAME")
> -    parser.add_option("-d", "--database", action="store", dest="dbname", default="rteval",
> +    parser.add_argument("-d", "--database", action="store", dest="dbname", default="rteval",
>                        help="Database to use (default: %default)", metavar="DATABASE")
> -    parser.add_option("-r", "--rterid", action="store", dest="rterid", default=None,
> +    parser.add_argument("-r", "--rterid", action="store", dest="rterid", default=None,
>                        help="rteval run id to remove from the database", metavar="INTEGER")
> -    (opts, args) = parser.parse_args()
> +    opts = parser.parse_args()
>  
>      if opts.rterid is None:
>          print "%s:  Missing --rterid value" % sys.argv[0]
> diff --git a/server/rteval_testserver.py b/server/rteval_testserver.py
> index 6cac85bcfe52..c7f9ce954b21 100644
> --- a/server/rteval_testserver.py
> +++ b/server/rteval_testserver.py
> @@ -30,7 +30,6 @@ import sys
>  import signal
>  from xmlrpc.server import SimpleXMLRPCServer
>  from xmlrpc.server import SimpleXMLRPCRequestHandler
> -from optparse import OptionParser
>  import argparse
>  
>  import xmlrpc_API1
> -- 
> 2.39.3
> 
> 

