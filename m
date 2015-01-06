From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: Re: RT is freezing
Date: Mon, 05 Jan 2015 23:26:42 -0200
Message-ID: <54AB39D2.2090203@gmail.com>
References: <54AB147E.9060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:64829 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbbAFB0q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Jan 2015 20:26:46 -0500
Received: by mail-vc0-f173.google.com with SMTP id kv19so8688605vcb.32
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Jan 2015 17:26:45 -0800 (PST)
Received: from [192.168.0.13] ([201.53.181.238])
        by mx.google.com with ESMTPSA id ck20sm16253953vdb.17.2015.01.05.17.26.44
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2015 17:26:44 -0800 (PST)
In-Reply-To: <54AB147E.9060209@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It seems that the problem is with the nouveau driver. When I boot in 
failsafe graphic mode,  the system works well. Here is my video 
configuration:
$ lshw -c video
   *-display
        description: VGA compatible controller
        product: GF108M [GeForce GT 540M]
        vendor: NVIDIA Corporation
        physical id: 0
        bus info: pci@0000:01:00.0
        version: a1
        width: 64 bits
        clock: 33MHz
        capabilities: pm msi pciexpress vga_controller bus_master 
cap_list rom
        configuration: driver=nouveau latency=0
        resources: irq:53 memory:f4000000-f4ffffff 
memory:d0000000-dfffffff memory:e0000000-e1ffffff ioport:d000(size=128) 
memory:f5000000-f507ffff


On 01/05/2015 08:47 PM, Gustavo Bittencourt wrote:
> Hi everybody
>
> I compiled the 3.14.25-rt22, but my system freezes when I start Unity 
> and some programs like Chrome or Thunderbird. The problem happens only 
> when PREEMPT_RT_FULL=y. No log is generated. I would like to find the 
> root of this problem, but I don't know how. Do you have any suggestion?
>
> Best regard,
> Gustavo Bittencourt

