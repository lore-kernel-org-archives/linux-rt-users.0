From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.8.4-rt2
Date: Thu, 25 Apr 2013 17:09:12 +0200
Message-ID: <51794718.5040703@linutronix.de>
References: <20130326201722.GA14220@linutronix.de> <CAP=VYLoXfECaSBuvYdZ3qbsnR9QMYpoRnKGZdY=P6zS_TYOcCA@mail.gmail.com> <20130408183012.GA5778@linutronix.de> <20130408152558.627dc8b1@riff.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44513 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035Ab3DYPJS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 11:09:18 -0400
In-Reply-To: <20130408152558.627dc8b1@riff.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/08/2013 10:25 PM, Clark Williams wrote:
> BTW I imported -rt onto v3.8.6 with no hiccups from 'git
> quiltimport' other than what you just fixed. Not much runtime on it
> but it booted without complaint and ran just fine until I tried a
> suspend/resume.
> 
> Resume seems to be borken on all the 3.8-rt kernels so far.

I just tested in qemu:
- suspend to mem
  the kvm support gives a few warn ons due to sleeping spinlocks in
  apf_task_wake_all(). Without it, it works just fine.

- suspend to disk
  I see very often "NOHZ: local_softirq_pending" warnings. It looks
  like the softirq thread is going down and the timer softirq isn't
  handled for instance. Apart from this warning I see the going into
  suspend and waking up.

> 
> Clark

Sebastian
