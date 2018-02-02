From: "Mills, William" <wmills@ti.com>
Subject: Linux stable vs RT stable and RT dev
Date: Fri, 2 Feb 2018 19:00:12 +0000
Message-ID: <8155aea247374c058bd7c797124c3d28@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "Murphy, Dan" <dmurphy@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:28650 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753344AbeBBTAO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Feb 2018 14:00:14 -0500
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w12J0D25000349
        for <linux-rt-users@vger.kernel.org>; Fri, 2 Feb 2018 13:00:13 -0600
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w12J0DXd027121
        for <linux-rt-users@vger.kernel.org>; Fri, 2 Feb 2018 13:00:13 -0600
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am trying to understand the policy WRT the RT stable branches and the Lin=
ux stable releases.
It appears not every Linux stable gets its own RT stable. [1]

What is the goal? =20
	Not getting behind by more than X weeks?
	Only change when RT series needs to be updated?
What is the expected consumer model?:
	Use only the version published by the maintainer
	Merge in upstream point release themselves between rt-stable releases
How is the policy different for rt-dev vs rt-stable?

I know Steven wrote up a stable RT maintainer's howto but I did not find it=
.  Can I get a pointer?
I did find Steven's slides from 2106[2] and skimmed them.

[1] https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/older/
[2] https://wiki.linuxfoundation.org/_media/realtime/events/rt-summit2016/h=
ow-much-stable-do-we-need_steven-rostedt.pdf

Long version / background
---------------------------------------------------------------------------=
--------
TI publishes 3 variants of our kernel for customers:
	Base + TI + [Linaro LSK]
	Base + TI + RT
	Base + TI + Android Common

All this is based on the latest GKH LTS and there is maintenance of last ye=
ars LTS

(Yes we understand this is all very simple if the TI set is nil.  We have n=
ever achieved that to date.  In the very least it is backports from tip to =
latest LTS.  In reality it is more.)

Right now Base above is always the very latest stable from GKH LTS.  It is =
auto merged as soon as it is published and picked up by our nightly builds.=
   Any merge conflict in any of the variants stops auto merge progress.

In this structure we tend to be the first to merge RT with a new stable.  M=
ost of the time this is OK but sometimes it is not.

Is it reasonable / expected for us to get ahead of you or should we arrange=
 things to just wait?

I used 4.9 in this example but right now we are executing this on 4.14, 4.9=
, and (somewhat) 4.4.

Thanks,
Bill

---------------------------------------------------
William A. Mills
Chief Technologist, Open Source
Texas Instruments, Processors
20450 Century Blvd
Germantown MD, 20874
(work/mobile) +1-240-643-0836

