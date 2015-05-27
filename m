From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Wed, 27 May 2015 17:50:00 +0200
Message-ID: <20150527175000.4f7f9c30@archlinux>
References: <20150519213923.GA26363@linutronix.de>
	<20150527114457.6d5ac8d5@balder.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt users <linux-rt-users@vger.kernel.org>
To: Joakim Hernberg <jhernberg@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail33c50.megamailservers.eu ([91.136.10.43]:36401 "EHLO
	mail33c50.megamailservers.eu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753330AbbE0QBl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2015 12:01:41 -0400
In-Reply-To: <20150527114457.6d5ac8d5@balder.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 27 May 2015 11:44:57 +0200, Joakim Hernberg wrote:
>I see the following trying to build based on archlinux' default config:

Hi Joakim,

I'll test if I need to build with
# CONFIG_X86_POWERNOW_K8 is not set
resp. if I need to remove the k8 module from
/lib/modules/.*/drivers/cpufreq/ as soon as a PKGBUILD for kernel 4 is
available.

The last kernel I tested was
$ pacman -Q linux-rt
linux-rt 3.18.9_rt5-2
perhaps you remember that I needed to disable CONFIG_X86_POWERNOW_K8.

I wonder how many AMD machines suffer from this issue.

Regards,
Ralf
