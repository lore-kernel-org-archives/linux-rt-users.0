From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.19-rt6, yum/rpm
Date: Thu, 7 Dec 2006 13:13:44 +0100
Message-ID: <20061207121344.GA19749@elte.hu>
References: <20061205171114.GA25926@elte.hu> <4577FC21.1080407@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Mike Galbraith <efault@gmx.de>,
	Clark Williams <williams@redhat.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Giandomenico De Tullio <ghisha@email.it>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1032097AbWLGMPR@vger.kernel.org>
To: "K.R. Foley" <kr@cybsft.com>
Content-Disposition: inline
In-Reply-To: <4577FC21.1080407@cybsft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo Molnar wrote:
> > i have released the 2.6.19-rt6 tree, which can be downloaded from the 
> > usual place:
> 
> Attached patch fixes rtc histogram. Looks like it got broken around 
> 2.6.18-rt?, probably during the merge for 2.6.18?

thanks, applied. I have undone some rtc hacks in the 2.6.18 merge, i 
guess this collateral damage of that.

	Ingo
