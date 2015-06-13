From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: Re: [ANNOUNCE] rt-tests v0.92
Date: Sat, 13 Jun 2015 11:41:04 +0200
Message-ID: <20150613114104.6ff44c05@tor.valhalla.alchemy.lu>
References: <alpine.LFD.2.10.1506091552470.10554@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Anna-Maria Gleixner <anna-maria@glx-um.de>,
	Clark Williams <williams@redhat.com>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:54636 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbbFMJlK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 13 Jun 2015 05:41:10 -0400
In-Reply-To: <alpine.LFD.2.10.1506091552470.10554@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 9 Jun 2015 16:11:20 +0200 (CEST)
John Kacur <jkacur@redhat.com> wrote:

> 
> I'm pleased to announce v0.92 of rt-tests, thanks everyone for the 
> patches!

There is a test in the hwlatdetect script that checks for the existence
of the hwlat_detector module.  This fails if the modules have been
compressed and also if the driver is built into the kernel.

-- 

   Joakim
