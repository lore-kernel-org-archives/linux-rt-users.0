Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A732C43334
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Jul 2022 16:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiGOQ4j (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Jul 2022 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiGOQ4i (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Jul 2022 12:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C608679EF7
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jul 2022 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657904196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDSNuxBUIThTYS24Ha4dFQ5kDajVDYVu6HVLSR5OTZY=;
        b=ONPoM1PTAjgLWZ6smFBfOGY4x+xpUiqx86LVthw3pm5lkzETuijMosIjKatsLm8SiUSBcA
        8aNp8BtWYwJVrN2qTFGa40k+pYyndgMwzk4DD73R4ymTWglzdkniC+FO/Jow572aPuJOa1
        frO1K0qXYNc0UTPPRSyH200ers3/gOU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-DjMlNwMkOvydcycrod_bdg-1; Fri, 15 Jul 2022 12:56:34 -0400
X-MC-Unique: DjMlNwMkOvydcycrod_bdg-1
Received: by mail-qt1-f197.google.com with SMTP id w24-20020ac843d8000000b0031ecbfedc25so3961190qtn.15
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jul 2022 09:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=pDSNuxBUIThTYS24Ha4dFQ5kDajVDYVu6HVLSR5OTZY=;
        b=dZ6KXz5shwfKklHDUj4TxdnoHxhrsy26ESRzrZZPFQMnshnTBNrBKjHFbTvrOwoU9A
         BvCBusAvBP7Nl7D7ffkkl13BAEZ7yvsFTmdYMuTT1HX27pHfoHSUpKFbiZhRxoYo09YH
         StDNpvINl8zeiPXL8z2a7HnUCltCDbol2WeikqNOeks4e9PtfIt4pCoJnnRwrJD13NGO
         w4MdYkNQf1Wx9x/j3a/nI3K3QPW/WftCVMLEdKRNsK5C1Xf+x+3kGuHCXfZvEvYCg9Ps
         nxBwRjZUTyMQF948jzuqp/SpVzoVD8PMKUntcbgW6wPR8mU5pMlgvAn1Qb/NI7XrPjvw
         pNdw==
X-Gm-Message-State: AJIora/0BPGa0AR7RzQbphQqBgqAJtsup5raO+DfiGLkhrHI6rUH2TeX
        Azi0FnmHe4GlJ/awpadq1kxKzytmmMG49BowDnei+LFSLcD9Fo4XJ5FEuvfv1OKGHlblZhS9qYP
        P9b75owl5vgg97+boey16L13XPaE=
X-Received: by 2002:a05:6214:19c8:b0:472:f250:2d97 with SMTP id j8-20020a05621419c800b00472f2502d97mr12621721qvc.13.1657904194405;
        Fri, 15 Jul 2022 09:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1unyicVx2umR9N1DoD8mD62yPgqs2POGustMx0S6NyfqD0IfKJs6TG7KHwzfFQ5QnUXlBSYCw==
X-Received: by 2002:a05:6214:19c8:b0:472:f250:2d97 with SMTP id j8-20020a05621419c800b00472f2502d97mr12621707qvc.13.1657904194183;
        Fri, 15 Jul 2022 09:56:34 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a410d00b006af10bd3635sm4518175qko.57.2022.07.15.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 09:56:33 -0700 (PDT)
Date:   Fri, 15 Jul 2022 12:56:10 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Manasi Godse <magodse@redhat.com>
cc:     linux-rt-users@vger.kernel.org, lleshchi@redhat.com,
        kcarcia@redhat.com
Subject: Re: [PATCH] rteval: Add option for downloading kernel
In-Reply-To: <20220713202531.398854-1-magodse@redhat.com>
Message-ID: <4c67edd-f0d4-de0-af35-283cf5ddcf11@redhat.com>
References: <20220713202531.398854-1-magodse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 13 Jul 2022, Manasi Godse wrote:

> Added an option -S, --source-download to download a kernel source
> tarball from kernel.org to the appropriate loadsource directory.
> Acceptable strings for the kernel version are 'linux-5.18.1.tar.xz;,
> 'linux-5.18.1.tar.gz', 'linux-5.18.1', '5.18.1', 'linux-5.19-rc5'.
> 
> Conditions have been added to check for default kernel packaged with
> rteval-loads and backing up the tarball if it already exists. This
> enhancement simplifies the  manual downloading of kernel to the loadsource
> directory.
> 
> Signed-off-by: Manasi Godse <magodse@redhat.com>
> ---
>  rteval-cmd             | 61 ++++++++++++++++++++++++++++++++++++++++++
>  rteval/rtevalConfig.py |  1 +
>  2 files changed, 62 insertions(+)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index 4598ba514ddc..dcd06dc30ba4 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -37,8 +37,11 @@
>  import sys
>  import os
>  import time
> +import re
> +import shutil
>  import optparse
>  import tempfile
> +import requests
>  import lxml.etree
>  from rteval.Log import Log
>  from rteval import RtEval, rtevalConfig
> @@ -46,6 +49,7 @@ from rteval.modules.loads import LoadModules
>  from rteval.modules.measurement import MeasurementModules
>  from rteval.version import RTEVAL_VERSION
>  from rteval.misc import invert_cpulist, compress_cpulist
> +from rteval.modules.loads.kcompile import ModuleParameters
>  
>  def summarize(repfile, xslt):
>      """ Summarize an already existing XML report """
> @@ -158,6 +162,10 @@ def parse_options(cfg, parser, cmdargs):
>      parser.add_option("-V", "--version", dest="rteval___version",
>                        action='store_true', default=False,
>                        help='print rteval version and exit')
> +    parser.add_option("-S", "--source-download", dest="rteval___srcdownload",
> +                        type="string", default=None, metavar="KERNEL_VERSION",
> +                        help='download a source kernel from kernel.org')
> +
>  
>      if not cmdargs:
>          cmdargs = ["--help"]
> @@ -254,6 +262,59 @@ if __name__ == '__main__':
>          measuremods.SetupModuleOptions(parser)
>          cmd_args = parse_options(config, parser, sys.argv[1:])
>  
> +        # download kernel tarball
> +        if rtevcfg.srcdownload:
> +            logger.log(Log.DEBUG, f"Kernel Version to download = {rtevcfg.srcdownload}")
> +
> +            # handle a kernel version like linux-5.19-rc5
> +            if 'rc' in rtevcfg.srcdownload:
> +                kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", rtevcfg.srcdownload).group(0)
> +                url = "https://git.kernel.org/torvalds/t/"
> +            else:
> +                kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", rtevcfg.srcdownload).group(0)
> +                major_version = re.search(r"\d{1,2}", kernel_prefix).group(0)
> +                url = "https://kernel.org/pub/linux/kernel/v" + major_version + ".x/"
> +
> +
> +            if rtevcfg.srcdownload.endswith(".gz") or 'rc' in rtevcfg.srcdownload:
> +                rtevcfg.srcdownload = "linux-" + kernel_prefix + ".tar.gz"
> +            else:
> +                rtevcfg.srcdownload = "linux-" + kernel_prefix + ".tar.xz"
> +            tarfl = os.path.join(rtevcfg.srcdir, rtevcfg.srcdownload)
> +
> +            # if default kernel packages with rteval-loads exists, do not download/overwrite
> +            default_kernel_file = ModuleParameters().get('source').get('default')
> +            if os.path.exists(tarfl):
> +                if rtevcfg.srcdownload == default_kernel_file:
> +                    sys.exit("Default kernel already exists, will not download")
> +                prompt = input("Kernel already exists, download and overwrite anyways? (y/n)  ")
> +                prompt = prompt.lower()
> +                if prompt in ('no', 'n'):
> +                    sys.exit("Exiting")
> +                elif prompt in ('yes','y'):
> +                    # backup the existing kernel in case it needs to be restored later
> +                    shutil.move(tarfl, tarfl + ".bkup")
> +                else:
> +                    sys.exit("Invalid option. Exiting")
> +
> +            url = url + rtevcfg.srcdownload
> +            print(f"Downloading kernel {url}")
> +            downloaded_file = requests.get(url)
> +            if downloaded_file.status_code != 200:
> +                # restore the kernel file if it exists
> +                if os.path.exists(tarfl + ".bkup"):
> +                    shutil.move(tarfl + ".bkup", tarfl)
> +                sys.exit(f"Could not download tar file {rtevcfg.srcdownload}, status code {downloaded_file.status_code}")
> +            with open(tarfl, 'wb') as fd:
> +                fd.write(downloaded_file.content)
> +            logger.log(Log.DEBUG, f"Kernel source {rtevcfg.srcdownload} downloaded successfully")
> +            logger.log(Log.DEBUG, f"Downloaded to directory location: {rtevcfg.srcdir}")
> +            # download was successful, delete the backup file if it exists
> +            if os.path.exists(tarfl + ".bkup"):
> +                os.remove(tarfl + ".bkup")
> +            sys.exit(0)
> +
> +
>          # if we only specified one set of cpus (loads or measurement)
>          # default the other to the inverse of the specified list
>          ldcfg = config.GetSection('loads')
> diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
> index 56bbc9ee0de6..decd36ed18ab 100644
> --- a/rteval/rtevalConfig.py
> +++ b/rteval/rtevalConfig.py
> @@ -97,6 +97,7 @@ default_config = {
>          'xslt_histogram': default_config_search(['rteval_histogram_raw.xsl'], os.path.isfile),
>          'report_interval': '600',
>          'logging'    : False,
> +        'srcdownload': None,
>          }
>      }
>  
> -- 
> 2.31.1
> 
> 
    Tested-by: Leah Leshchinsky <lleshchi@redhat.com>
    - Two small tweaks, non-standard "anyways" changed to "anyway", and
      added the words "and exit" to the end of the help option
    Signed-off-by: John Kacur <jkacur@redhat.com>

