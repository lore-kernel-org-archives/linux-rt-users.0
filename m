From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] KVM: PPC: Convert openpic lock to raw_spinlock
Date: Wed, 18 Feb 2015 09:40:51 +0100
Message-ID: <54E45013.4020005@linutronix.de>
References: <1421919555-11631-1-git-send-email-bogdan.purcareata@freescale.com> <54CF44EC.3050007@freescale.com> <54E333C0.5000908@freescale.com> <20150217175317.GB26177@linutronix.de> <20150217175922.GC26177@linutronix.de> <54E44DF8.1080906@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, scottwood@freescale.com,
	Mihai Caraman <mihai.caraman@freescale.com>,
	linux-kernel@vger.kernel.org
To: Purcareata Bogdan <b43198@freescale.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E44DF8.1080906@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/18/2015 09:31 AM, Purcareata Bogdan wrote:
> Thanks! Will send a patchset separating these 2 functional changes - the
> openpic raw_spinlock for upstream ppc (since it doesn't bring any
> changes anyway), and the MAX_VCPUS limitation for the RT tree.

thanks. please cc me on both.

>> This remains of my multiple-MSI patch which someone other posted a while
>> ago. What happend to it?
> 
> I'm not aware of this patch, could you give more details, please?

I just grabed them from archive and it seems that there were change
requests from Scott which were not done. Forget it then, I had it
differently in memory.

> 
> Bogdan P.

Sebastian
