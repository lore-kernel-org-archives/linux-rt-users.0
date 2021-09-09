Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABA2C4332F
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 12:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05A161059
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 12:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbhIIMsy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 08:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354304AbhIIMmz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 08:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631191305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cLWSslhsEJxg7+ho3qzfZz3KNLLFdpK0/nz67IHkOAE=;
        b=YCSTkqUis+TX+eldpPaQs+UHQFBWSkyzn8+MPL2UgDrJzVKOtY8Za0aEs5CGD7S8r3PLMh
        HTOdsIW6e+9Q4E3SozAU5KEysHmvGQq5m3Z861uZfNaighrzdSeTXKFF+o02Rd2YOObLdo
        NPqTYLdYjbCnqEogYGa0YkDQve4f3BE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-IkbMFCQpMACw1vOthwOYig-1; Thu, 09 Sep 2021 08:41:44 -0400
X-MC-Unique: IkbMFCQpMACw1vOthwOYig-1
Received: by mail-io1-f72.google.com with SMTP id z26-20020a05660200da00b005b86e36a1f4so1732371ioe.15
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 05:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=cLWSslhsEJxg7+ho3qzfZz3KNLLFdpK0/nz67IHkOAE=;
        b=dJ5J39NNMtPa3N1qwSJel25sFHK4y54X6viU/3R9qRk8eSiy8bd6ddlBmdjK2nE9NX
         qFrI47YgUMf2k4/VFWEaF5FuFTMz9RXGQ4vu08b7JeyzOHlSzTJRDWg1qQtx/tLdoFgq
         Um3QfMB0VWDCw5Sm8IAYRruRDgM+REmsm80ybmRsYzmVULDJIlq2CYkj5tBbc7B4Xiyc
         rAP5oQ1geSDnOBRD97XIfoWaxtPZk8fb8n9hYwsVyCgSjnhPo8hcI14oRCPBnwnz9DfC
         D1PjSooMUdUCcitGI8HRWbyBm0NWY9GyBydRJcbdk2rWZRGmdmar+T9A53HmFgPuG2jo
         vslw==
X-Gm-Message-State: AOAM530/NpPGzRXu5WnJHHdJYGMlrbAUT94jT2hHhTPk6RicLnvnrdnO
        ApkjnzQx1IBoMHcGU93KrjG6+bZ9yqTRDlqbBHEa005s5/6bDHAm/15/7UDeHlh8ZUkVYLE6Rza
        6cggwPV54At0NStyeeq/a1Li/ncM=
X-Received: by 2002:a92:d3cf:: with SMTP id c15mr2230902ilh.131.1631191303860;
        Thu, 09 Sep 2021 05:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkME4IlwjJfFIPTXFKnx2CEPNjgTjGjv+X0n5Jw5fwf2IUAlJyXAEhb4y8MWEMip5TGMXUlw==
X-Received: by 2002:a92:d3cf:: with SMTP id c15mr2230885ilh.131.1631191303609;
        Thu, 09 Sep 2021 05:41:43 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id k7sm825759iok.22.2021.09.09.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:41:43 -0700 (PDT)
Date:   Thu, 9 Sep 2021 08:41:42 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/5] rteval: cyclictest.py: Update logic to get core
 description
In-Reply-To: <20210901080816.721731-3-punitagrawal@gmail.com>
Message-ID: <633d388d-13d9-6155-e4da-ca135c0df44@redhat.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com> <20210901080816.721731-3-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 1 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> Certain architectures such as arm and arm64 don't have a "model name"
> in /proc/cpuinfo but provide other identifying information such as
> implementer, architecture, variant, part, revision, etc..
> 
> Add a function 'get_cpumodel()' that takes the per-core dictionary
> constructed from /proc/cpuinfo and uses the available data to
> construct the CPU description. Update the users of "model name" to use
> the newly added function.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/misc.py                           | 23 ++++++++++++++++++++++-
>  rteval/modules/measurement/cyclictest.py |  8 +++++---
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/rteval/misc.py b/rteval/misc.py
> index 0dd361ff19fd..537041b53d61 100644
> --- a/rteval/misc.py
> +++ b/rteval/misc.py
> @@ -79,6 +79,27 @@ def cpuinfo():
>          info[core][key] = val
>      return info
>  
> +# Pass the per-core dictionary that is part of the dictionary returned
> +# by cpuinfo()
> +def get_cpumodel(core_info):
> +    desc = core_info.get('model name', '')
> +    if not desc:
> +        # On Arm (both 32 and 64 bit), 'CPU Implementer' is always
> +        # present. Return 'unknown' otherwise
> +        if 'CPU implementer' not in core_info:
> +            desc = 'unknown'
> +        else:
> +            implementor = core_info.get('CPU implementer', '')
> +            architecture = core_info.get('CPU architecture', '')
> +            variant = core_info.get('CPU variant', '')
> +            part = core_info.get('CPU part', '')
> +            revision = core_info.get('CPU revision', '')
> +
> +            desc = 'Implementor: %s Architecture: %s Variant: %s Part: %s Revision: %s' \
> +                % (implementor, architecture, variant, part, revision)
> +
> +    return desc
> +
>  if __name__ == "__main__":
>  
>      info = cpuinfo()
> @@ -86,4 +107,4 @@ if __name__ == "__main__":
>      for i in idx:
>          print("%s: %s" % (i, info[i]))
>  
> -    print("0: %s" % (info['0']['model name']))
> +    print("0: %s" % (get_cpumodel(info['0'])))
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index b1755d4f4421..11cb45e711dd 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -34,7 +34,7 @@ import math
>  import libxml2
>  from rteval.Log import Log
>  from rteval.modules import rtevalModulePrototype
> -from rteval.misc import expand_cpulist, online_cpus, cpuinfo
> +from rteval.misc import expand_cpulist, online_cpus, cpuinfo, get_cpumodel
>  
>  class RunData:
>      '''class to keep instance data from a cyclictest run'''
> @@ -226,13 +226,15 @@ class Cyclictest(rtevalModulePrototype):
>          for core in self.__cpus:
>              self.__cyclicdata[core] = RunData(core, 'core', self.__priority,
>                                                logfnc=self._log)
> -            self.__cyclicdata[core].description = info[core]['model name']
> +            self.__cyclicdata[core].description = get_cpumodel(info[core])
> +            if self.__cyclicdata[core].description == 'unknown':
> +                self._log(Log.INFO, "Unknown model for core %d" % core)
>  
>          # Create a RunData object for the overall system
>          self.__cyclicdata['system'] = RunData('system',
>                                                'system', self.__priority,
>                                                logfnc=self._log)
> -        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0']['model name']
> +        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + get_cpumodel(info['0'])
>  
>          if self.__sparse:
>              self._log(Log.DEBUG, "system using %d cpu cores" % self.__numcores)
> -- 
> 2.32.0
> 
> 

I like the idea of constructing the 'model name' from other fields in 
/proc/cpuinfo available for arm.

There are a number of problems with the implementation.
This should be written in such away that the local changes in misc.py
work seamlessly without changes to the code that calls it. The code should 
also add the 'model name' to every core.
Finally, a lesser detail, but there is no need when using get to set a 
default of "" when the default is already None. Just make the code work 
with None.

I have rewritten this from scratch, attributing the idea to you, I hope 
that is okay. I will send the patch to the list shortly.

John

