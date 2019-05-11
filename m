Return-Path: <SRS0=YGts=TL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEBBC04AB1
	for <linux-rt-users@archiver.kernel.org>; Sat, 11 May 2019 13:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7557F2146F
	for <linux-rt-users@archiver.kernel.org>; Sat, 11 May 2019 13:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfEKNr1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 11 May 2019 09:47:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55981 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfEKNr1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 11 May 2019 09:47:27 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hPSLS-00043U-VX; Sat, 11 May 2019 15:47:23 +0200
Date:   Sat, 11 May 2019 15:47:22 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Issue with RT patchset refresh on top of 4.9.175 as rebase for
 stretch due to 59c39840f5abf4a71e1810a8da71aaccd6c17d26
Message-ID: <20190511134722.3v4dhf7fs3uqy3a4@linutronix.de>
References: <20190511120422.GA1212@eldamar.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="icy2eghms55htbfr"
Content-Disposition: inline
In-Reply-To: <20190511120422.GA1212@eldamar.local>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--icy2eghms55htbfr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-11 14:04:22 [+0200], Salvatore Bonaccorso wrote:
> Hi Sebastian,
Hi Salvatore,

> I wonder if you can help me out on the following issue in case there
> will be no new RT patchsets for the 4.9 series soonish. I'm working on
> importing new 4.9 upstream version to be released in future stretch
> point releases.
>=20
> https://salsa.debian.org/kernel-team/linux/merge_requests/141
>=20
> is my current work in progress with an import of 4.9.175 for stretch.
> Though the backport of 59c39840f5ab ("genirq: Prevent use-after-free
> and work list corruption") ro 4.9.175 will cause issues for the RT
> patchset:
=E2=80=A6
> /home/build/linux-4.9.175/debian/build/source_rt/kernel/irq/manage.c: In =
function 'irq_set_affinity_notifier':
> /home/build/linux-4.9.175/debian/build/source_rt/kernel/irq/manage.c:375:=
31: error: 'struct irq_affinity_notify' has no member named 'work'; did you=
 mean 'swork'?
>    cancel_work_sync(&old_notify->work);
=E2=80=A6
> Now I could have mail the kernel development mailinglist or rt-users
> mailinglist, the reason I did contact you directly is that I have not
> found if the issue was already raised.

Nope, I'm not aware of it.

> Will there be new RT patchsets soon as the various stable branches all
> contained that commit (v5.1.1~19, v5.0.15~23, v4.19.42~17,
> v4.14.118~13 and v4.9.175~10), or should I try to work on refreshing
> the patchsets on my own, ideally with your help here :)

Please find attached an archive with three patches. That are basically
backports from the v5.0-RT tree. The kswork does not offer a "flush" which
would be required. I feel more comfortable to switch to the kthread
based infrastructure (which is used in the v5.0-RT tree) than adding the
required flush bits (and testing and so on) to kwork.

> Thanks for your time reading so far!
>=20
> Regards,
> Salvatore

Sebastian

--icy2eghms55htbfr
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kwork.tar.xz"
Content-Transfer-Encoding: base64

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
+qsHlgAB0ByAoAEAa2hBWbHEZ/sCAAAAAARZWg==

--icy2eghms55htbfr--
