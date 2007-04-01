From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: 2.6.21-rc5-rt6 make errors
Date: Sun, 01 Apr 2007 18:12:19 +0100
Message-ID: <460FE7F3.4060303@rncbc.org>
References: <23932.213.58.131.130.1170156409.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpa2.netcabo.pt ([212.113.174.17]:6260 "EHLO
	exch01smtp01.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933666AbXDARTJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Apr 2007 13:19:09 -0400
In-Reply-To: <23932.213.58.131.130.1170156409.squirrel@www.rncbc.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

Just tried to build 2.6.21-rc5-rt6 and it is failing on build time.

=2E..
kernel/sched.c: In function =E2=80=98__schedule=E2=80=99:
kernel/sched.c:3830: error: =E2=80=98print_functions=E2=80=99 undeclare=
d (first use in
this function)
kernel/sched.c:3830: error: (Each undeclared identifier is reported onl=
y
once
kernel/sched.c:3830: error: for each function it appears in.)
=2E..
arch/i386/kernel/apic.c: In function =E2=80=98smp_apic_timer_interrupt=E2=
=80=99:
arch/i386/kernel/apic.c:589: error: invalid lvalue in assignment
arch/i386/kernel/apic.c:608: error: invalid lvalue in assignment
=2E..

Just to let you know that -rt5 was doing fine with very same .config .

Cheers.
--=20
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
