Return-Path: <SRS0=n5VO=T7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE412C04AB6
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 May 2019 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B9126C80
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 May 2019 16:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEaQvX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 May 2019 12:51:23 -0400
Received: from mr014msr.fastwebnet.it ([85.18.95.110]:56854 "EHLO
        mr014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaQvX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 May 2019 12:51:23 -0400
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudefuddguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhtefuvfghgfeupdcuqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffuvfhfkffffgggjggtgfesthekredttdefjeenucfhrhhomhepifhiuhhlihgrnhhoucevohhllhgruceoghhiuhhlihgrnhhordgtohhllhgrsehfrghsthifvggsnhgvthdrihhtqeenucfkphepudehuddrtddrudeluddrudegudenucfrrghrrghmpehhvghlohepmhhitghrohhsvghrvhgvrhdrlhhotggrlhguohhmrghinhdpihhnvghtpeduhedurddtrdduledurddugedupdhmrghilhhfrhhomhepoehgihhulhhirghnohdrtgholhhlrgesfhgrshhtfigvsghnvghtrdhithequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehlihhnuhigqdhrthdquhhsvghrshesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsrghntggvlhhothesnhhumhgrlhhlihgrnhgtvgdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from microserver.localdomain (151.0.191.141) by mr014msr.fastwebnet.it (5.8.208) (authenticated as giuliano.colla)
        id 5CB685AD02166E4D; Fri, 31 May 2019 18:51:19 +0200
From:   Giuliano Colla <giuliano.colla@fastwebnet.it>
Subject: Re: intel j1900 and i915 realtime problems
To:     =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
References: <bf7df0b0-64b4-910f-137e-1eba406d3f52@numalliance.com>
Message-ID: <e8b5ac8d-2ff1-791f-98da-4f4854676873@fastwebnet.it>
Date:   Fri, 31 May 2019 18:51:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bf7df0b0-64b4-910f-137e-1eba406d3f52@numalliance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: it-IT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Il 22/05/2019 14:10, Stéphane Ancelot ha scritto:
> Hi,
>
> I have got a problem with a celeron j1900 platform and i915 driver.
>
> I have 3 realtime tasks that are launched sequentially.
>
> task1 is clocked periodically at 3ms.
>
> task1 wakes up task2 and takes 2 wakes up task 3 using priority 
> scheduling (and SCHED_FIFO mechanism).
>
> everything works well, until I am using graphic applications with 
> activity (hide/show gui programs...,widgets creation /refresh etc).
>
> The task1 always start periodically each 3ms, but the other threads 
> execution time are delayed.
>
> I mean normally, the whole computing processing timing 
> (task1+task2+task3) takes normally around 800us time execution.
>
> When I stress the graphic pages, This time becomes up to 1.6ms.
>
> The 3 tasks are isolated on a cpu. I don't think the problem is 
> involved by the CPU, but more by i915 driver and memory.
>
> I have not managed to identify the right reason with perf utility.
>
> One thing I am sure :
>
> if I run the same gui pages through an ssh shell, the problem has not 
> appeared. realtime is not "broken"
>
> I know that the intel driver is involved.
>
> I would need some help to identify the right problem and for finding 
> solutions.ideas.
>
> Regards,
>

What priorities you have given to your RT tasks?

I have experienced that running on an isolated CPU is not enough to 
ensure that the scheduling of your tasks is not influenced by other 
activities. In order to have my RT tasks running properly, I've been 
forced not only to set policy to SCHED_FIFO, but also to set a priority 
as high as possible, sort of:

       mysched.sched_priority = 99;
         if( sched_setscheduler( 0, policy, &mysched ) == -1 ) {
	......

for the first task, and slghtly lower priorities to the others.

Then with *top *you may see where are positioned your tasks in the 
scheduler priority.

Here's a snapshot of Top output (sorted by priority), with my 15 RT 
tasks being, in order of priority, /ymain/ to /erhndl/. Very little has 
higher priority, and all the rest has lower. This setup for me is 
insensitive to CPU graphic activities.



Of course if in your case the i915 driver happens to have a higher 
priority than the one you can manage to obtain programmatically for your 
tasks, then you're out of luck.

Hope that it helps,

Giuliano


-- 
Do not do to others as you would have them do to you.They might have different tastes.

