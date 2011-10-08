From: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Subject: Re: [ANNOUNCE] 3.0.6-rt17
Date: Sat, 08 Oct 2011 22:56:24 +0200
Message-ID: <4E90B8F8.3070507@gmail.com>
References: <alpine.LFD.2.02.1110070046270.3240@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55063 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab1JHU42 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Oct 2011 16:56:28 -0400
In-Reply-To: <alpine.LFD.2.02.1110070046270.3240@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/07/2011 03:15 AM, Thomas Gleixner wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.0.6-rt17 release.
>
> After chasing weird RCU stalls and hung task messages for quite some
> time a massive collaborative effort was able to track down and fix
> this showstopper. Explanation from the changelog:
snip.

+static int __init dmi_disable_hpet_msi(const struct dmi_system_id *d)
+{
+	hpet_msi_disable = 1;
+}


I just noticed this from watching build output after upgrading from rt14, shouldn't it return a value?

Also, I sent something about memory cgroups to linux-rt-users, but never received a reply, is that ml still used?

Cheers,
Maarten

