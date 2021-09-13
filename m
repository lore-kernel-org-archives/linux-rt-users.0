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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8695C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 02:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0AF60FED
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 02:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhIMC3l (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 22:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbhIMC3l (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Sep 2021 22:29:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C111C061574
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 19:28:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q68so7984087pga.9
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 19:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WGbz5z15hfZaXk7EZizIjcXbDvOlubHAynHt0zFnVsU=;
        b=nk0xmueFy/ZRt9rLta7TMB1ErKtDSZJKqFlAGt0FEE6D3xJzxw67uguQRq0ALvBeGm
         06ThQx76LrV8mD7a4YxiOq+PkoIU+bSZl8TUwBaggUanFEUuwYi/3Z1ADxawwB1IVhlp
         mKSQ/L22KG0SYJU2ZV9mjdML2oVNckwRIBRacFZI6xLltqnJ7Kb/1ey0Gx0uGLru8Bp4
         YUIzliS8fnHHEZq4RMbo7HcpbHdCXeZglvNIRdCXjM53WY+9fu0EsiYVhuvRHVZr6qlm
         yY/Br4CxeJivzyIgZPuu1s2hrEU2OXMx1lNKudTSZ4mYeAJx/KIxywb9hAbokNYOwPvu
         xcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WGbz5z15hfZaXk7EZizIjcXbDvOlubHAynHt0zFnVsU=;
        b=PNozOM4I/p8YJTbCTZlMFrg7x2+RtZM98EtdYrec9zhXP6hmYWj6GMR2DiXR7VD/vJ
         SLND/v1YWCC3qx1Ih0SnigBDWBGlCLwnKbIwHLM2/mVi2LXYKHw7Jf53uI1gA27H6c19
         FEyk304tKYgkH/QdVmmebWGizrUrOWu3K1qBNMkd1Ca4iwk58fE3uzGCnOj0TZ3R/Jec
         CZcdvITeNsZKIKmPJTxZb4DJSsBxSr8QFOvuDwT5FASviePi86OIAxz/n5j+1rLBdq+a
         qX3IWCHI5RgOC/fTRqArqrpUykC+O5JFuleO91LPjRScTH8Szf9Luv8l0GumBC79duf6
         /5zg==
X-Gm-Message-State: AOAM530trcL/FdaAu65pbemvtR4dr1bjJDJCm2Ijp4cjNa8weCKYe5oz
        j8YSQlC+ND1e8C6wfhWRjcg=
X-Google-Smtp-Source: ABdhPJxRgIoIXmgUobtaGGELjv/KyEUOOBFyVhNfhK0hamXJdeujtfCSEhCH4Npf4exsGC2uurTUEw==
X-Received: by 2002:a62:d104:0:b0:3ee:46b:d4ed with SMTP id z4-20020a62d104000000b003ee046bd4edmr8902234pfg.38.1631500105676;
        Sun, 12 Sep 2021 19:28:25 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id g11sm5830032pgn.41.2021.09.12.19.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 19:28:25 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/5] rteval: systopology.py: Add support for systems
 that don't have Numa
References: <20210901080816.721731-1-punitagrawal@gmail.com>
        <20210901080816.721731-2-punitagrawal@gmail.com>
        <b79752f-2af5-cc3f-2738-326d1cfced40@redhat.com>
Date:   Mon, 13 Sep 2021 11:28:22 +0900
In-Reply-To: <b79752f-2af5-cc3f-2738-326d1cfced40@redhat.com> (John Kacur's
        message of "Thu, 9 Sep 2021 08:34:56 -0400 (EDT)")
Message-ID: <87zgsh9pkp.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

John Kacur <jkacur@redhat.com> writes:

> On Wed, 1 Sep 2021, Punit Agrawal wrote:
>
>> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> 
>> Certain systems such as Arm v7 do not have support for Numa nodes,
>> i.e., "/sys/devices/system/node*" does not exist. Instead of erroring
>> out in this situation, it would be better if rteval could use
>> alternate sources to get the system topology and memory information.
>> 
>> Introduce the notion of a fake Numa node (as a class) which is used
>> when no numa nodes are found on the system. Other than the
>> constructor, it provides the same interface as the existing NumaNode
>> class so existing users should work without any changes.
>> 
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> ---
>>  rteval/systopology.py | 38 ++++++++++++++++++++++++++++++++------
>>  1 file changed, 32 insertions(+), 6 deletions(-)
>> 
>> diff --git a/rteval/systopology.py b/rteval/systopology.py
>> index c61ec1a58514..7ce9a8c4f707 100644
>> --- a/rteval/systopology.py
>> +++ b/rteval/systopology.py
>> @@ -191,6 +191,31 @@ class NumaNode:
>>          """ return list of cpus for this node """
>>          return self.cpus.getcpulist()
>>  
>> +class FakeNumaNode(NumaNode):
>> +    """class representing a fake NUMA node. The fake NUMA node is used on
>> +    systems which don't have NUMA enabled (no
>> +    /sys/devices/system/node) such as Arm v7
>> +
>> +    """
>> +
>> +    cpupath = '/sys/devices/system/cpu'
>> +    mempath = '/proc/meminfo'
>> +
>> +    def __init__(self):
>> +        self.nodeid = 0
>> +        self.cpus = CpuList(sysread(FakeNumaNode.cpupath, "possible"))
>> +        self.getmeminfo()
>> +
>> +    def getmeminfo(self):
>> +        self.meminfo = {}
>> +        for l in open(FakeNumaNode.mempath, "r"):
>> +            elements = l.split()
>> +            key = elements[0][0:-1]
>> +            val = int(elements[1])
>> +            if len(elements) == 3 and elements[2] == "kB":
>> +                val *= 1024
>> +            self.meminfo[key] = val
>> +
>>  #
>>  # Class to abstract the system topology of numa nodes and cpus
>>  #
>> @@ -238,12 +263,13 @@ class SysTopology:
>>  
>>      def getinfo(self):
>>          nodes = glob.glob(os.path.join(SysTopology.nodepath, 'node[0-9]*'))
>> -        if not nodes:
>> -            raise RuntimeError("No valid nodes found in %s!" % SysTopology.nodepath)
>> -        nodes.sort()
>> -        for n in nodes:
>> -            node = int(os.path.basename(n)[4:])
>> -            self.nodes[node] = NumaNode(n)
>> +        if nodes:
>> +            nodes.sort()
>> +            for n in nodes:
>> +                node = int(os.path.basename(n)[4:])
>> +                self.nodes[node] = NumaNode(n)
>> +        else:
>> +            self.nodes[0] = FakeNumaNode()
>>  
>>      def getnodes(self):
>>          return list(self.nodes.keys())
>> -- 
>> 2.32.0
>> 
>> 
>
> This is quite clever. I am just going to rename Fake to Sim as short for 
> simulated, but other than that.
>
> Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks for taking a look.

I'll take a look at the updates you sent and respond there as
appropriate.

Regards,
Punit
