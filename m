Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0CEC433FE
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 12:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABDC61100
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 12:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352821AbhIIMlY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 08:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352878AbhIIMgO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 08:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631190899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3TA+gg4cRpfREavneKcKGs5CSHUMkFwoZczAbXzaZDI=;
        b=L5NYFFu37GD9q8dBG08AIq7oIK6xM5Vp46RY3nvpxD8X8C44iqO+wpJmM1PlxttSQIluli
        z05wMle5zG1uXs5y1VvModPJGEL0u6cWBlWnqY/g0UNwQDFvgxEkEu8eGE1fjzjPKNu6G1
        atFcrQNZDZidRTTSY/sPKskPaSjeBeY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-BZ_VGpx9MIeHV7ZHplyIYg-1; Thu, 09 Sep 2021 08:34:58 -0400
X-MC-Unique: BZ_VGpx9MIeHV7ZHplyIYg-1
Received: by mail-qt1-f198.google.com with SMTP id o22-20020ac872d60000b029029817302575so4360188qtp.10
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 05:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=3TA+gg4cRpfREavneKcKGs5CSHUMkFwoZczAbXzaZDI=;
        b=MNcNi1wKbgYYsW/Hhzseut491PlljT+tucGbYVyMNiew0V8tlLmijSDL7Di+qR0HD6
         7hMp8tdSw4HuCPcXZipIPPvHWffPSALqcXpfcwXiiaLdcy53tBylckJP+jBg7CUm/y+u
         G3icK2yNNgeag0v3qijsNVS3rnxiBHLYXHiI0WAsYoZHa9h/p+ypDY8mdgEb3CKoMCw0
         JkdWxQe0Y7jGKYiQtJcxC4AeVClB5AAPJXrcqcGAhVVO+OenRGkYvxswQaHF2GBIBE3L
         JY7UiyAADCqPeOoAsIH3FRJrWoZPhaSIHxbX8x3fy4OBuNLpqoHA7uNMYusgRiQis9tK
         gJXQ==
X-Gm-Message-State: AOAM531zMeCjDYPmXDL3rN9VNA+CfJsLoRiHdcT3H5JjMZvl+fImguMN
        Fz420udrLI5Y6X3rXcNzjsxXYoDoN2T+aYcFSAcz58HDy3NPIspFkp4QWlZsDTHhEb+/L05IRUo
        yH8tb73d5cyQtFk1/QSwexq8ZYjo=
X-Received: by 2002:a37:aa92:: with SMTP id t140mr2479316qke.164.1631190898100;
        Thu, 09 Sep 2021 05:34:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPfdlEMrFJONQseTIfYvvUy85stWbYSl06Z1K+VgyQOVXsZrW4oBsKohStuB6od0bbBZXT4Q==
X-Received: by 2002:a37:aa92:: with SMTP id t140mr2479299qke.164.1631190897891;
        Thu, 09 Sep 2021 05:34:57 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id s18sm1215984qkj.87.2021.09.09.05.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:34:57 -0700 (PDT)
Date:   Thu, 9 Sep 2021 08:34:56 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/5] rteval: systopology.py: Add support for systems that
 don't have Numa
In-Reply-To: <20210901080816.721731-2-punitagrawal@gmail.com>
Message-ID: <b79752f-2af5-cc3f-2738-326d1cfced40@redhat.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com> <20210901080816.721731-2-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 1 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> Certain systems such as Arm v7 do not have support for Numa nodes,
> i.e., "/sys/devices/system/node*" does not exist. Instead of erroring
> out in this situation, it would be better if rteval could use
> alternate sources to get the system topology and memory information.
> 
> Introduce the notion of a fake Numa node (as a class) which is used
> when no numa nodes are found on the system. Other than the
> constructor, it provides the same interface as the existing NumaNode
> class so existing users should work without any changes.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/systopology.py | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/rteval/systopology.py b/rteval/systopology.py
> index c61ec1a58514..7ce9a8c4f707 100644
> --- a/rteval/systopology.py
> +++ b/rteval/systopology.py
> @@ -191,6 +191,31 @@ class NumaNode:
>          """ return list of cpus for this node """
>          return self.cpus.getcpulist()
>  
> +class FakeNumaNode(NumaNode):
> +    """class representing a fake NUMA node. The fake NUMA node is used on
> +    systems which don't have NUMA enabled (no
> +    /sys/devices/system/node) such as Arm v7
> +
> +    """
> +
> +    cpupath = '/sys/devices/system/cpu'
> +    mempath = '/proc/meminfo'
> +
> +    def __init__(self):
> +        self.nodeid = 0
> +        self.cpus = CpuList(sysread(FakeNumaNode.cpupath, "possible"))
> +        self.getmeminfo()
> +
> +    def getmeminfo(self):
> +        self.meminfo = {}
> +        for l in open(FakeNumaNode.mempath, "r"):
> +            elements = l.split()
> +            key = elements[0][0:-1]
> +            val = int(elements[1])
> +            if len(elements) == 3 and elements[2] == "kB":
> +                val *= 1024
> +            self.meminfo[key] = val
> +
>  #
>  # Class to abstract the system topology of numa nodes and cpus
>  #
> @@ -238,12 +263,13 @@ class SysTopology:
>  
>      def getinfo(self):
>          nodes = glob.glob(os.path.join(SysTopology.nodepath, 'node[0-9]*'))
> -        if not nodes:
> -            raise RuntimeError("No valid nodes found in %s!" % SysTopology.nodepath)
> -        nodes.sort()
> -        for n in nodes:
> -            node = int(os.path.basename(n)[4:])
> -            self.nodes[node] = NumaNode(n)
> +        if nodes:
> +            nodes.sort()
> +            for n in nodes:
> +                node = int(os.path.basename(n)[4:])
> +                self.nodes[node] = NumaNode(n)
> +        else:
> +            self.nodes[0] = FakeNumaNode()
>  
>      def getnodes(self):
>          return list(self.nodes.keys())
> -- 
> 2.32.0
> 
> 

This is quite clever. I am just going to rename Fake to Sim as short for 
simulated, but other than that.

Signed-off-by: John Kacur <jkacur@redhat.com>

