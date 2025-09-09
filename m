Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4573019CD
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Sep 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421796; cv=none; b=ol6Xq5/9OuiOHzLrvRYxLxLvwoyqgfAHQGkkpP7j8S06JHxTQhL/ix3MfL1C5k5Tw8BPNUX0lCdnlMy8nxXLZ+3/58wLlzF/EDI0W3ZwvfmVoGExVztd3RatH1EeXAvt8ucmxjH22v+zIhMZo0tQIh20ntcRxSaz3N5i4XjB+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421796; c=relaxed/simple;
	bh=ISRR8FubLV7ki9gsx1kfVdPPMkbkbJ7vQWlgx9Coi00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tljDO+pKHWpRxKxb+gfqpQt8QtrZsu4bFfC9TDBCRjKIH8R0/tIh2L+4y1pkO6TtDP5K6fz4PG26cQFO+r3hn014JLt/WF4GyAH12EcD1VrPAnTRYFnmw0CXir9ppIUu/NH0AvygD7VjVWs7+ApKDYWsIffjvY9qcYvfo3yiuhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Oz1yu3+J; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Oz1yu3+J"
Received: from [IPV6:2a01:e34:ec24:52e0:4e45:8447:d6c0:1a95] (unknown [IPv6:2a01:e34:ec24:52e0:4e45:8447:d6c0:1a95])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id AD3CE2003CE;
	Tue,  9 Sep 2025 14:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757421791;
	bh=ISRR8FubLV7ki9gsx1kfVdPPMkbkbJ7vQWlgx9Coi00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Oz1yu3+Jw/c0vTV0X+fZAulqnmI9bCfPY2aYdetQuNwMFE7ftgAgNILoGnyDYHMyM
	 QjIlq80Y8aXasNru368l7PxSJBaiNHRfVUUGtro1deWZ1LkMXxb96lbp4V745/E5Jf
	 NwNzoTvMZl/xfyJUbzF6F1z2IyW8i0Kfk8PNRFGwZYtOJPPIVHsrnms8xViLZxCq80
	 B+lHsvZUOrgj7kybpqpjq3StuQRvXFOX5unTOUMZ2Fy2scSrekZF40Wtd4VBvjw3u9
	 g6aKid9FeAnoK2hAfAlXA/qvbVoeKfGJcFg8Ub9eA+iRjrBkZWvsB6ukLhOoCNzO61
	 zz1cGEGtSyIQw==
Message-ID: <1e374b4f-5410-4986-8849-ed2e8acdc23f@free.fr>
Date: Tue, 9 Sep 2025 14:42:54 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of trivial program
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-rt-users@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
 Leon Woestenberg <leon@sidebranch.com>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 John McCalpin <mccalpin@tacc.utexas.edu>,
 Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <afc4c145-4758-4924-b106-e7844624d269@free.fr>
 <841polf13z.fsf@jogness.linutronix.de>
 <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
 <84ldmsevcm.fsf@jogness.linutronix.de>
 <3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
 <84ldmp8ewv.fsf@jogness.linutronix.de>
 <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
 <d5f3d4c1-714b-46d4-99e6-c71ebf64e76b@flourine.local>
 <3220a6ab-19e5-4705-865a-1e1c37b67ccf@free.fr>
 <0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr>
 <79de8d5e-bf07-4c24-89e1-1ed5bfab9361@flourine.local>
Content-Language: en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <79de8d5e-bf07-4c24-89e1-1ed5bfab9361@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2025 13:21, Daniel Wagner wrote:

>> I note that IRQs 25 & 30 are still effectively pinned to CPU3,
>> despite the smp_aff setting.
>>
>> $ cat /proc/interrupts 
>>            CPU0       CPU1       CPU2       CPU3       
>>   0:         27          0          0          0   IO-APIC   2-edge      timer
>>   8:          0          0          0          0   IO-APIC   8-edge      rtc0
>>   9:          0          4          0          0   IO-APIC   9-fasteoi   acpi
>>  16:          0         25          0          0   IO-APIC  16-fasteoi   ehci_hcd:usb1
>>  18:          0          5          0          0   IO-APIC  18-fasteoi   i801_smbus
>>  23:          0          0         29          0   IO-APIC  23-fasteoi   ehci_hcd:usb2
>>  24:          0          0          0          0  PCI-MSI-0000:00:1c.0   0-edge      PCIe PME, pciehp
>>  25:          0          0          0          0  PCI-MSI-0000:00:1c.3   0-edge      PCIe PME
>>  26:      23328          0          0      37250  PCI-MSI-0000:00:1f.2   0-edge      ahci[0000:00:1f.2]
>>  27:      86091          0          0          0  PCI-MSI-0000:00:14.0   0-edge      xhci_hcd
>>  28:          0          0      51308          0  PCI-MSIX-0000:02:00.0  0-edge      enp2s0
>>  29:          0          0         22          0  PCI-MSI-0000:00:16.0   0-edge      mei_me
>>  30:          0          0          0        604  PCI-MSI-0000:00:1b.0   0-edge      snd_hda_intel:card0
>>  31:     198664          0          0          0  PCI-MSI-0000:00:02.0   0-edge      i915
>>  32:          0        631          0          0  PCI-MSI-0000:00:03.0   0-edge      snd_hda_intel:card1
> 
> Many drivers are not isolcpus aware. At least the sound driver could be
> unloaded for your test I suppose.

I don't quite understand.
Do these drivers explicitly request that their ISR run on CPU3?
Why doesn't the kernel just run these ISRs on a non-isolated core?

>> Almost exactly 20 ms in excess.
>> Could this be a hint?
>> But there is absolutely NOTHING traced between 4606.628019 & 4606.811832.
> 
> Ensure your clock source is working correctly and...
> 
>> I guess either my time source is incorrect.
>> (Next slide in Frederic's guide)
>> OR there is something wonky going on inside CPU3.
> 
> ...there is no SMI running on this CPU, and no power management running
> (also in the BIOS settings)

Actually, I'm 99.9% sure that clock source accuracy & SMM are red herrings.

If I replace my code with this one:

	mov $(1<<12), %eax
1:	dec %ecx
	dec %ecx
	dec %eax
	jnz 1b

which runs in ~2735 nanoseconds at 3 Ghz
(2 cycles per iteration * 4096 iterations = 8192 cycles
8192 cycles / 3 = 2730 nanoseconds)

Running this trivial baseline benchmark 2^16 times should take
2735 ns * 2^16 = 179.241 ms

And if I run the loop 1000 times, and sort by run-time, I observe
MIN=179.374211 ms
MAX=179.406745 ms
So worst-case is only 166 microseconds worse than expected
(contrast this to 20 MILLIseconds for my code, 120 times worse)

It seems something is randomly stalling the pipeline on CPU3.
This feels like thermal throttling maybe?
Is that supposed to be logged somewhere?
But why would my program throttle & not the trivial baseline benchmark?

Regards

