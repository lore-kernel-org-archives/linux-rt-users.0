Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F212EC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 06:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66AB60F5B
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 06:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbhIMGDe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 02:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhIMGDe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 02:03:34 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EDFC061574
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 23:02:19 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k24so8420021pgh.8
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 23:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=DqMGLMBfuTbAFLTGWFs8uwKhKh1mexnjk7/+E4EWljk=;
        b=F3JE572tLNuW1faueZ9vlObYUbZBIxEHZFnEIPx2lRfXW7f5y+ST0pGPPnVOjjVuKP
         hvraK9gckBvFwl9Vc9ulVoFhr4GYEVK7NS/QdD+cVPzafLDUx7z0L6jDvyf0mFbzlGk+
         ulDN0C7DkJ2qev/W9n3wFc8T++XXnx1tToYt8KPmj4me4IK4ymZWbx/DwzNvozT0oMs9
         0o/znG6P5usBo7t0DFxs0MajifJYsc8BpEErSpIQoPwbsGYTed6jfeAtiw79FR1E6NQt
         y8fo+RkbQsY+mxCi1/a+bm7VF/wtj6HX06loqbAoIWr32vkOHXgTCZ6ysy949LJwfvNz
         +zDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=DqMGLMBfuTbAFLTGWFs8uwKhKh1mexnjk7/+E4EWljk=;
        b=BldBe+XY5kVGH/fWil9Yb1dgJf0eQ52W1F+u9VfBzGIm4mVNpMOfAMQUXPTmt0lwzf
         wEjaUobXLrz24yZVeAfe6q49W7NI3T+d7xSlbwXqPmqsSxiSsu0tOznsEqQEpSSr/ugF
         AOs+UkIbbfVq6CnE1G7+eUlSrIyy7P8jkLR9kPRcN7G01f5OvQ1vtJz/l1X8ozQhcpBA
         nM6yOUpHHgz0UC5r8M69usrqiWd1Tr4r4sBy8ySwfZzLVXDeSH7mVAuNVCTWCgGTT86+
         86tU0EkohMK/+1YIo5A+R9tmhyZay1j5mfjpHrgyz/T2y5+pc6HRK2n9RQv2ssSMtDEe
         RTiw==
X-Gm-Message-State: AOAM531OQquz1OOlj2qC0nlas/khBqO8ebNTgcuAO660P6CWmnGb6JaJ
        /lYzT3r3rgL+NXrYzQgiba4=
X-Google-Smtp-Source: ABdhPJzpTm2Oaht18uB4ClGaQ1uuWkXY8+NiJM9+kM2ggF1nhH+ohHQ5MhAKXB+Y5k7d3Dj7iz6MEQ==
X-Received: by 2002:a63:68e:: with SMTP id 136mr9766885pgg.383.1631512938704;
        Sun, 12 Sep 2021 23:02:18 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id v4sm5734728pff.11.2021.09.12.23.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 23:02:18 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: Re: [PATCH 3/3] rteval: systopology.py: Add support for systems
 that don't have Numa
In-Reply-To: <20210909130314.6109-3-jkacur@redhat.com> (John Kacur's message
        of "Thu, 9 Sep 2021 09:03:14 -0400")
References: <20210909130314.6109-1-jkacur@redhat.com>
        <20210909130314.6109-3-jkacur@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 13 Sep 2021 15:02:15 +0900
Message-ID: <87h7ep9fo8.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

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
> - Renamed Fake to Sim for simulated
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  rteval/systopology.py | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/rteval/systopology.py b/rteval/systopology.py
> index c61ec1a58514..3c996048f8c1 100644
> --- a/rteval/systopology.py
> +++ b/rteval/systopology.py
> @@ -191,6 +191,30 @@ class NumaNode:
>          """ return list of cpus for this node """
>          return self.cpus.getcpulist()
>  
> +class SimNumaNode(NumaNode):
> +    """class representing a simulated NUMA node.
> +    For systems which don't have NUMA enabled (no
> +    /sys/devices/system/node) such as Arm v7
> +    """
> +
> +    cpupath = '/sys/devices/system/cpu'
> +    mempath = '/proc/meminfo'
> +
> +    def __init__(self):
> +        self.nodeid = 0
> +        self.cpus = CpuList(sysread(SimNumaNode.cpupath, "possible"))
> +        self.getmeminfo()
> +
> +    def getmeminfo(self):
> +        self.meminfo = {}
> +        for l in open(SimNumaNode.mempath, "r"):
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
> @@ -238,12 +262,13 @@ class SysTopology:
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
> +            self.nodes[0] = SimNumaNode()
>  
>      def getnodes(self):
>          return list(self.nodes.keys())

The name changes look good and passed a test run of rteval on a system
with no numa nodes.

Thanks,
Punit
