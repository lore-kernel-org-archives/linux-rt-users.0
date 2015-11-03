From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v4.1.10-rt10][PATCH 1/2] genirq: introduce new
 generic_handle_irq_rt_wa() api
Date: Tue, 3 Nov 2015 21:18:28 +0100
Message-ID: <56391694.3030105@linutronix.de>
References: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com>
 <1446492626-24396-2-git-send-email-grygorii.strashko@ti.com>
 <alpine.DEB.2.11.1511022036500.4032@nanos> <563906C5.8030801@ti.com>
 <alpine.DEB.2.11.1511032014580.4032@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sekhar Nori <nsekhar@ti.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1511032014580.4032@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 11/03/2015 08:51 PM, Thomas Gleixner wrote:
>> where MAX_MSI_IRQS = 32 now, but potentially can be increased up to 256.
> 
> And you really oversimplified the code above. The reality is:
> 
>     for (i = 0; i < MAX_MSI_CTRLS: i++) {
>     	u32 status = read_msi_ctrl(i);
> 
> 	for_each_bit(status)
> 		handle_irq();
>     }
> 
> So sure, the worst case here is MAX_MSI_CTRLS * 32, but if all
> possible 256 MSI interrupts are pending at the same time, you have
> other problems than that.

With threaded interrupts we would have 256 invocations of
wake_up_process() so nothing should take ages.

> Thanks,
> 
> 	tglx

Sebastian
