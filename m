From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [v4.1.10-rt10][PATCH 1/2] genirq: introduce new
 generic_handle_irq_rt_wa() api
Date: Thu, 5 Nov 2015 18:44:56 +0200
Message-ID: <563B8788.1090000@ti.com>
References: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com>
 <1446492626-24396-2-git-send-email-grygorii.strashko@ti.com>
 <alpine.DEB.2.11.1511022036500.4032@nanos> <563906C5.8030801@ti.com>
 <alpine.DEB.2.11.1511032014580.4032@nanos> <56391694.3030105@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Sekhar Nori <nsekhar@ti.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56391694.3030105@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas, Sebastian,

On 11/03/2015 10:18 PM, Sebastian Andrzej Siewior wrote:
> On 11/03/2015 08:51 PM, Thomas Gleixner wrote:
>>> where MAX_MSI_IRQS = 32 now, but potentially can be increased up to 256.
>>
>> And you really oversimplified the code above. The reality is:
>>
>>      for (i = 0; i < MAX_MSI_CTRLS: i++) {
>>      	u32 status = read_msi_ctrl(i);
>>
>> 	for_each_bit(status)
>> 		handle_irq();
>>      }
>>
>> So sure, the worst case here is MAX_MSI_CTRLS * 32, but if all
>> possible 256 MSI interrupts are pending at the same time, you have
>> other problems than that.
>
> With threaded interrupts we would have 256 invocations of
> wake_up_process() so nothing should take ages.
>

Thanks a lot for your time and comments - I'll follow your
recommendations and use IRQF_NO_THREAD.

-- 
regards,
-grygorii
