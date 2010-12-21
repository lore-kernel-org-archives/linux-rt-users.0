From: David Peverley <pev@sketchymonkey.com>
Subject: A couple of Questions about the RT Patch
Date: Tue, 21 Dec 2010 14:42:27 +0000
Message-ID: <AANLkTinUpZGFB8YijVkFMfScwf8rARG8Rikx+NQBbUtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:36924 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab0LUOm1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Dec 2010 09:42:27 -0500
Received: by gwb20 with SMTP id 20so2829968gwb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Dec 2010 06:42:27 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I'm broadly familiar with the RT patch but have recently started
working on an=A0embedded project that utilises a kernel based around
linux 2.6.31-rt20 and so am trying to get better up to speed with
using the patch in practice. Our platform=A0is running on an ARM11 base=
d
SoC (has no SoC specific driver changes for the RT preempt).

As I understand it, the different kernel releases of the patch are
sequential as opposed to parallel, i.e. the newer patches on new
kernels such as the just announced 2.6.33.7-rt29,=A0supersede=A0the
earlier releases and changes don't get back-ported top earlier
kernels. As we don't have the option to update the kernel revision to
keep in sync with the later RT patches, can anyone tell me if we
should be considering evaluating changes from later patches to
back-port and if so, is there a straight-forward way to find out=A0what
changes (or sets of changes) if any are important to bring in or are
we fine just sticking at .31-rt20? I don't think we've found anything
glaringly obviously needing fixing yet and it's nice not to have to
always play catch up with new releases!

I've also wanted to look into doing some tests to see how this
platform performs. I've built the RT-Tests package and run hackbench
and cyclictest on my board but I'm not sure how to evaluate the
results I'm seeing! It seems to me that most documents I've read
evaluate the results by comparing to someone elses baseline results
however I haven't seen any results for similar boards (ARM11 @ 400MHz
/ 64Mb SDRAM with no swap)=A0Could someone give me any references or
pointers?

Cheers!

~Pev
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
