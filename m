Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3B2C433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 13:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77425619EB
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 13:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbhIMNgw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 09:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242987AbhIMNeo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 09:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631540004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jTT45g0fwwR9uCcDkF5gWJC0A+jVZQidBoLrBlTWH5s=;
        b=BmZSucIQh02oZSYLXUYs7bC+Q2TwLAUKS605cfQj6sm4cSA0KsWndljlanqaW5Qb3A19zd
        sl3Q7eLu0lScBzg9fFd7YsDlmRdszcLDnwSOjFrogpF3n5JBD5WOX++5KLBhCc3ovY3R+h
        k01KXDWjsWhiILqToi4nb3xdvV/DPZk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-wD6fk_GTO6GWE4uqCbbDnA-1; Mon, 13 Sep 2021 09:33:23 -0400
X-MC-Unique: wD6fk_GTO6GWE4uqCbbDnA-1
Received: by mail-io1-f69.google.com with SMTP id n8-20020a6b7708000000b005bd491bdb6aso13833370iom.5
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 06:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=jTT45g0fwwR9uCcDkF5gWJC0A+jVZQidBoLrBlTWH5s=;
        b=3A0Os7KbyyWTiXbOxtj8PRA0xHGNN1pstLuBL+qE1p3fLAQBHJ2Cl+oCORVH1Wtt/S
         6joyy8rhlE95PBwLB94/+OqcZwYCFWq39xbrIJ/BNFmzlwGUvk2R/mNaNNsEI95Coh2a
         qvZDmCbSdj6DctTxwPqWCorXtEVMSgX2HwsBnfTRK5COsgt6OpJjW7s3WJsK4eeg/Uc6
         n6o/qWT2+Yp2y2w0esb4QraLfFo9yk1r+TZNVcuaPewo7IyQvTNs29xi4oqwbCWyGGba
         7VpJawJFaKSifhzE3B0SMVDI1sKcTWpuiMBbk6+4d0MWbvlRli990JEqCDgaW/OxQWj2
         6BLw==
X-Gm-Message-State: AOAM530XuHSJ9FbL+hVgifGsULvgDHjdVI+uRUUeWRbZvxg01i76iHgu
        HblfvQ/LwTop9vCzJRB9yWvlzQRfxa4drKzXgBNmNplvcSj2+ZWopOYnO+f1oiDQmDW2U7pNfJ6
        NOpPQjPDSRKEJa0/EvBtAxfC1D2A=
X-Received: by 2002:a6b:c3ce:: with SMTP id t197mr9059483iof.159.1631540002422;
        Mon, 13 Sep 2021 06:33:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqnZWHdeiMGxXJTcZSwf6oiVFoQ7VDVyhQAq/2Eu/kJhCUSTbFkJpPnH5OQEhU9K/Hl5zKDg==
X-Received: by 2002:a6b:c3ce:: with SMTP id t197mr9059467iof.159.1631540002192;
        Mon, 13 Sep 2021 06:33:22 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id l17sm4827290ilt.24.2021.09.13.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:33:21 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:33:20 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     linux-rt-users@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: Re: [PATCH v2] rteval: services.py: Fix incorrect detection of
 container environment
In-Reply-To: <20210913080625.2017964-1-punitagrawal@gmail.com>
Message-ID: <6f4a1723-8084-537-9362-53c6d32d57a1@redhat.com>
References: <d18a85b5-d591-a21b-c7fc-93655f7963c@redhat.com> <20210913080625.2017964-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 13 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> rteval mistakenly detects that it is running inside a container even
> though it is running directly on the host. On further investigation
> this was found to be due to change in behaviour around byte strings
> and strings when going from python2 to python3.
> 
> In python3 process output (stdout, stderr) for processes executed via
> Popen() is retuned as byte strings and byte strings are not equivalent
> to strings, i.e., b'' == '' is False.
> 
> Update all call sites for Popen() to include "text=True"
> argument - this ensures that the process output is returned as a
> string.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
> v1 -> v2:
> * Update Popen() calls to return strings for process output
> ---
>  rteval/sysinfo/services.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/rteval/sysinfo/services.py b/rteval/sysinfo/services.py
> index 06ff5ae9cd0c..283109b9b234 100644
> --- a/rteval/sysinfo/services.py
> +++ b/rteval/sysinfo/services.py
> @@ -62,11 +62,11 @@ class SystemServices:
>              if not [1 for p in reject if fnmatch.fnmatch(servicename, p)] \
>                      and os.access(service, os.X_OK):
>                  cmd = '%s -qs "\(^\|\W\)status)" %s' % (getcmdpath('grep'), service)
> -                c = subprocess.Popen(cmd, shell=True)
> +                c = subprocess.Popen(cmd, shell=True, text=True)
>                  c.wait()
>                  if c.returncode == 0:
>                      cmd = ['env', '-i', 'LANG="%s"' % os.environ['LANG'], 'PATH="%s"' % os.environ['PATH'], 'TERM="%s"' % os.environ['TERM'], service, 'status']
> -                    c = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
> +                    c = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
>                      c.wait()
>                      if c.returncode == 0 and (c.stdout.read() or c.stderr.read()):
>                          ret_services[servicename] = 'running'
> @@ -81,9 +81,9 @@ class SystemServices:
>          ret_services = {}
>          cmd = '%s list-unit-files -t service --no-legend' % getcmdpath('systemctl')
>          self.__log(Log.DEBUG, "cmd: %s" % cmd)
> -        c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
> +        c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
>          for p in c.stdout:
> -            # p are lines like "servicename.service status"
> +            # p are lines like b'servicename.service status'
>              v = p.strip().split()
>              ret_services[v[0].split('.')[0]] = v[1]
>          return ret_services
> @@ -91,7 +91,7 @@ class SystemServices:
>  
>      def services_get(self):
>          cmd = [getcmdpath('ps'), '-ocomm=', '1']
> -        c = subprocess.Popen(cmd, stdout=subprocess.PIPE)
> +        c = subprocess.Popen(cmd, stdout=subprocess.PIPE, text=True)
>          self.__init = c.stdout.read().strip()
>          if self.__init == 'systemd':
>              self.__log(Log.DEBUG, "Using systemd to get services status")
> -- 
> 2.32.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>

