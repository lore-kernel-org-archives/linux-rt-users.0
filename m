Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81E4C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 01:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B97A65004
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 01:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCEBeQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Mar 2021 20:34:16 -0500
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:49078 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCEBeQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Mar 2021 20:34:16 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 1251XqmP002062; Fri, 5 Mar 2021 10:33:52 +0900
X-Iguazu-Qid: 34tIYccUdfq55oE8u1
X-Iguazu-QSIG: v=2; s=0; t=1614908032; q=34tIYccUdfq55oE8u1; m=Ya8613cNeC27aDUn8Qx2RS0Xc9D7ey+rfoRQhUn8AOI=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1512) id 1251XpBG024829
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 5 Mar 2021 10:33:51 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 6EFE310013C;
        Fri,  5 Mar 2021 10:33:51 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1251XpOR027572;
        Fri, 5 Mar 2021 10:33:51 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     dwagner@suse.de, "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: Re: [rteval PATCH v2 2/3] rteval: cyclictest.py: Make build targets architecture independent
References: <20210224021603.446274-1-punit1.agrawal@toshiba.co.jp>
        <20210224021603.446274-3-punit1.agrawal@toshiba.co.jp>
        <43eaa8bb-26a-112c-8c13-38fe882dbbb@redhat.com>
        <87im67tno4.fsf@kokedama.swc.toshiba.co.jp>
        <3d6cee93-577b-d06e-b440-d8c97615a544@redhat.com>
Date:   Fri, 05 Mar 2021 10:33:49 +0900
In-Reply-To: <3d6cee93-577b-d06e-b440-d8c97615a544@redhat.com> (John Kacur's
        message of "Thu, 4 Mar 2021 10:48:44 -0500 (EST)")
X-TSB-HOP: ON
Message-ID: <87a6ritmde.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> On Thu, 4 Mar 2021, Punit Agrawal wrote:
>
>> John Kacur <jkacur@redhat.com> writes:
>> 
>> > On Wed, 24 Feb 2021, Punit Agrawal wrote:
>> >
>> >> Not all kernel archiectures provide the "bzImage" target, e.g., arm64
>> >> provides "Image" which generates an uncompressed kernel binary.
>> >> 
>> >> Instead of going down the path of customizing build targets
>> >> per-architecture, let's drop them altogether. The default kernel
>> >> target should build the kernel and modules on all architectures
>> >> anyways.
>> >> 
>> >> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> >> ---
>> >>  rteval/modules/loads/kcompile.py | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> 
>> >> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
>> >> index 326f1ae..e747b9f 100644
>> >> --- a/rteval/modules/loads/kcompile.py
>> >> +++ b/rteval/modules/loads/kcompile.py
>> >> @@ -58,7 +58,7 @@ class KBuildJob:
>> >>          else:
>> >>              self.jobs = self.calc_jobs_per_cpu() * len(self.node)
>> >>          self.log(Log.DEBUG, "node %d: jobs == %d" % (int(node), self.jobs))
>> >> -        self.runcmd = "%s make O=%s -C %s -j%d bzImage modules" \
>> >> +        self.runcmd = "%s make O=%s -C %s -j%d" \
>> >>                  % (self.binder, self.objdir, self.kdir, self.jobs)
>> >>          self.cleancmd = "%s make O=%s -C %s clean allmodconfig" \
>> >>                  % (self.binder, self.objdir, self.kdir)
>> >> -- 
>> >> 2.30.0
>> >> 
>> >> 
>> >
>> > Signed-off-by: John Kacur <jkacur@redhat.com>
>> 
>> Hi John,
>> 
>> Thanks for picking up this patch.
>> 
>> Just wanted to make sure about the status of the other 2 patches in the
>> set - 1/3 and 3/3, I am assuming they're on your TODO but haven't had a
>> chance to confirm yet.
>> 
>> Let me know if that's not the case for some reason.
>> 
>> Thanks,
>> Punit
>> 
>
> Yes, they are on my TODO list, I will get to them.
> I will probably take the patch that deal with the model name, after I 
> convince myself that it won't break anything else.
>
> I don't really like the idea of a fake NUMA node to deal with rteval
> on non-NUMA machines, but I am open to ideas to get rteval working
> on such machines. On my list to give you feedback.

I am not too attached to the fake NUMA node either. The resulting patch
seemed like the least invasive way to make rteval more inclusive on
non-NUMA architectures.

I am open to alternate ways to enable this functionality. I'll look out
for your feedback once you've taken a closer look.

[...]

