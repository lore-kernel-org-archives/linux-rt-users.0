Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2480C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 04:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE07C22DD6
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 04:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbhAZE4l (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Jan 2021 23:56:41 -0500
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:59914 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbhAZBnb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Jan 2021 20:43:31 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 10Q1eTcV026805; Tue, 26 Jan 2021 10:40:29 +0900
X-Iguazu-Qid: 2wGqhgW4xAMwUt1EF4
X-Iguazu-QSIG: v=2; s=0; t=1611625229; q=2wGqhgW4xAMwUt1EF4; m=PGZcsDCdCzsU0ZWL83DLBcJYzsv2YtuEunCvIvUtXXQ=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1111) id 10Q1eSdN015274;
        Tue, 26 Jan 2021 10:40:28 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 10Q1eSfs003736;
        Tue, 26 Jan 2021 10:40:28 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 10Q1eSex013993;
        Tue, 26 Jan 2021 10:40:28 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>,
        dwagner@suse.de, linux-rt-users@vger.kernel.org
Subject: Re: Some issues running rteval on arm64, arm and i386
References: <877doa1uwx.fsf@kokedama.swc.toshiba.co.jp>
        <YApwIRJdMCXcMVbU@lx-t490>
        <8b5fcd1f-e78e-744d-836e-d1e4b2d5794@redhat.com>
Date:   Tue, 26 Jan 2021 10:40:27 +0900
In-Reply-To: <8b5fcd1f-e78e-744d-836e-d1e4b2d5794@redhat.com> (John Kacur's
        message of "Fri, 22 Jan 2021 18:31:40 -0500 (EST)")
X-TSB-HOP: ON
Message-ID: <8735yozd9w.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John, Ahmed,

John Kacur <jkacur@redhat.com> writes:

> On Fri, 22 Jan 2021, Ahmed S. Darwish wrote:
>
>> On Mon, Jan 18, 2021 at 06:00:46PM +0900, Punit Agrawal wrote:
>> >
>> > We ran into a few issues when trying to run rteval on arm64, arm and
>> > i386.
>> >
>> > A few of the assumptions in rteval don't hold true on these systems.
>> >
>> 
>> For some embedded devices, it can be tough to use rteval with it. In
>> general, it requires, *on the target*:
>> 
>>   1. a full development toolchain (GCC, make, flex, bison, etc.)
>>   2. a full kernel source tree
>>   3. a full Python environment
>> 
>> You can use a combination of stress-ng and cyclictest to properly
>> evaluate your preempt_rt system latencies. Just make sure to exclude the
>> stress-ng stressors which allocate real-time threads, which can (and do)
>> conflict with the cyclictest ones.

[...]

> I agree, rteval wasn't designed for the embedded world. The reason for the
> full development tool chain is to compile the kernel as a load, so if you 
> are compiling the kernel on a machine other than the device it is 
> targetted for, then rteval won't work. Also, yes it runs with a python3
> envirnoment, we still maintain a version for python2, but no new 
> development is occuring there.
>
> note that rteval can now run stress-ng too, but the default is without it.

Thanks for your comments.

Fortunately, the device filesystems can provide the dependencies
(toolchain, python3, etc.) of rteval. But I'll keep in mind alternative
ways to evaluate the system latencies when we can't.

Thanks,
Punit

[...]

