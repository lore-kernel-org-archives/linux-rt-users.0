Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A914C433F5
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 14:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3E061026
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 14:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhILPAx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 11:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhILPAx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Sep 2021 11:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631458778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2iHSCc9+XAbQCfx/ZGkq3SxdVNDHohHXG1jpww1T0Hk=;
        b=NnxEqw57DzQtpVqJsNKrf6WnyyzZF6yUeFKpXsqTFG9mnme1vJINxT85FkTV51WRzLPIE8
        QvFNxBBdsdBwUhH6WG2BHPm+Ki672Y9niV41BWuaIBjnLux8OZ8MjGDLhPruuToBNvbhjZ
        2F96I9p6TGpYvwRZfD9CaprTXtPoI4A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-0YQvWtK4M8eS3Gyb5-cC6Q-1; Sun, 12 Sep 2021 10:59:37 -0400
X-MC-Unique: 0YQvWtK4M8eS3Gyb5-cC6Q-1
Received: by mail-qv1-f71.google.com with SMTP id a11-20020a0ca98b000000b0037855a1171fso53792797qvb.12
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 07:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2iHSCc9+XAbQCfx/ZGkq3SxdVNDHohHXG1jpww1T0Hk=;
        b=1k+TCJ/Z1fyn2Myn3lT0KZB3Audl9eXjKbn7LO8FCNxCRM+tOVZVeBwEoc5bWUU1qZ
         r+iBkcJit9J8GE+u3A7XdZpZgrhCH2bCv1bDpALvrsJK8uqTDChrbyOH2yZL7JKFbbI3
         MJGniKb+yNzg5dtTD5UaOT0kXnMlEBGe6AiRZmwbXQxR0kGWt3t4/pYQZlBHiyaJaxsh
         KL98VMA/Ok7tk6kT+itci2lQoelk2IaTMqSbK1wwHWCs0veASMCuRCR2J3/Snfa95QZO
         a2TnxcZgFQ7l2opx3oyQ/1CIvC9k5mejTaAAgSdXcF+Qv4cCpMgLXGftWUqKCw60Z6s8
         DYgw==
X-Gm-Message-State: AOAM5323GWi9AWGth6Maz6E4+G40bxuW/P7bKfiUF6eETdr3Pe+iiGYt
        FBkfSHc1atPDYqCwNEVLm88XwnRexOUxhZkzijlb6Y5DufW7VsoeKXDMn78xppTrpF7CpPxqEZm
        MTExrDRMIP3kY/WTKXLbfAOYMVmk=
X-Received: by 2002:ac8:7594:: with SMTP id s20mr5854112qtq.381.1631458776763;
        Sun, 12 Sep 2021 07:59:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxglfawF/YE2I1sxcPZjvfTIozqgFhg4nGMz5vlQh08ZJjh0S62LbyowS/DkHj+cPZTGXx72A==
X-Received: by 2002:ac8:7594:: with SMTP id s20mr5854099qtq.381.1631458776493;
        Sun, 12 Sep 2021 07:59:36 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id r140sm3378741qke.15.2021.09.12.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 07:59:36 -0700 (PDT)
Date:   Sun, 12 Sep 2021 10:59:34 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: Re: [PATCH 2/2] rteval: services.py: Fix incorrect detection of
 container environment
In-Reply-To: <20210909080547.1331581-3-punitagrawal@gmail.com>
Message-ID: <d18a85b5-d591-a21b-c7fc-93655f7963c@redhat.com>
References: <20210909080547.1331581-1-punitagrawal@gmail.com> <20210909080547.1331581-3-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 9 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> rteval mistakenly detects that it is running inside a container even
> though it is running directly on the host. On further investigation
> this was found to be due to change in behaviour around byte strings
> and strings when going from python2 to python3.
> 
> In python3 byte strings are not equivalent to strings, i.e., b'' == ''
> is False. The string comparison functions in services.py are still
> relying on the old behaviour in python2 where they were equivalent.
> 
> Update the byte string processing by converting them to string.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/sysinfo/services.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/rteval/sysinfo/services.py b/rteval/sysinfo/services.py
> index 06ff5ae9cd0c..94857aea6be4 100644
> --- a/rteval/sysinfo/services.py
> +++ b/rteval/sysinfo/services.py
> @@ -83,8 +83,8 @@ class SystemServices:
>          self.__log(Log.DEBUG, "cmd: %s" % cmd)
>          c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
>          for p in c.stdout:
> -            # p are lines like "servicename.service status"
> -            v = p.strip().split()
> +            # p are lines like b'servicename.service status'
> +            v = p.decode().strip().split()
>              ret_services[v[0].split('.')[0]] = v[1]
>          return ret_services
>  
> @@ -92,7 +92,7 @@ class SystemServices:
>      def services_get(self):
>          cmd = [getcmdpath('ps'), '-ocomm=', '1']
>          c = subprocess.Popen(cmd, stdout=subprocess.PIPE)
> -        self.__init = c.stdout.read().strip()
> +        self.__init = c.stdout.read().decode().strip()
>          if self.__init == 'systemd':
>              self.__log(Log.DEBUG, "Using systemd to get services status")
>              return self.__get_services_systemd()
> -- 
> 2.32.0
> 
> 

Thanks, this looks good, I'm wondering however if the same result could be 
achieved by appending text=True to the subprocess command in each of those
methods? Would you like to test that and send me a new patch?

Thanks

John 

