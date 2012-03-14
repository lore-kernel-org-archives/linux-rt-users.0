From: Karsten Wiese <fzuuzf@googlemail.com>
Subject: Re: [PATCH RT 0/7] [ANNOUNCE] 3.0.23-rt40-rc1
Date: Wed, 14 Mar 2012 13:52:09 +0100
Message-ID: <201203141352.10145.fzuuzf@googlemail.com>
References: <20120314022658.783312660@goodmis.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54936 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab2CNMwQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Mar 2012 08:52:16 -0400
In-Reply-To: <20120314022658.783312660@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am Mittwoch 14 M=C3=A4rz 2012 schrieb Steven Rostedt:


> Changes from 3.0.23-rt39:
>=20
> ---
>=20
>=20
> Steven Rostedt (2):
>       Revert "ACPI: Convert embedded controller lock to raw spinlock"
>       Linux 3.0.23-rt40-rc1


How about also reverting the commit that has changed acpi_gbl_gpe_lock =
to a
raw spinlock?

Thanks,
Karsten
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
