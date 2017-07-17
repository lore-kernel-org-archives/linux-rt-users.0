From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Mon, 17 Jul 2017 18:59:13 +0100
Message-ID: <20170717175912.GA11283@westernst>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
 <ac7edffc-9f5f-527d-71b1-211ffa342ddc@numalliance.com>
 <AM3PR02MB1301C4E614B49A78835967DC1A00@AM3PR02MB130.eurprd02.prod.outlook.com>
 <3a2a9504-812c-466c-7417-7dce3490492e@jajcus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org,
        =?iso-8859-1?Q?St=E9phane?= Ancelot <sancelot@numalliance.com>,
        Piotr Gregor <pgregor@quadrant-systems.co.uk>
To: Jacek Konieczny <jajcus@jajcus.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34889 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdGQSCc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Jul 2017 14:02:32 -0400
Received: by mail-wr0-f177.google.com with SMTP id w4so26498095wrb.2
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Jul 2017 11:02:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3a2a9504-812c-466c-7417-7dce3490492e@jajcus.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Jacek,

I have a script to install rt-patched kernel and thought you may give it
a go.

https://github.com/spinlockirqsave/scripts/blob/master/rt.sh

Script allows for installation of several versions of kernels though
some of them may require update of the url link to download kernel or
patch as these links change every now and then. I am using this script
these days to install linux-4.4.70 with patch-4.4.70-rt83 patch on a
couple of machines with success. Please use default option in Step 3
and 6.3 Substep in Step 6 to install former and copy existing kernel
config.

cheers,
Piotr

On Mon, Jul 17, 2017 at 05:06:58PM +0200, Jacek Konieczny wrote:
> On 2017-07-17 08:21, Stéphane Ancelot wrote:
> > If you don't manage to achieve realtime, you have some wrong options in
> > your kernel settings .
> 
> I do achieve real-time (stable, low-enough latency), but it doesn't last.
> 
> 
> On 2017-07-17 08:31, Piotr Gregor wrote:
> > Just to clarify: does the laptop works fine with other, non-rt-patched kernel?
> 
> Yes.
> 
> > If yes, couldn't you copy existing config from /boot and make oldconfig based on that? 
> 
> I have not done exactly that – I have added the RT patch and
> CONFIG_PREEMPT_RT_FULL option (with dependencies) to the package source
> from which the original kernel was built.
> 
> I can try the 'make oldconfig' with a working non-rt kernel config next
> time, but I won't be able to do that in the next week.
> 
> > You may have to do some tricks to get GUI with reasonable graphics though
> > but this should give you runnable, stable system.
> 
> I use GUI applications, rely on working OpenGL. Graphics is 'reasonable'
> as long as the system is stable, but sooner or later it locks-up/crashes.
> 
> Here are two of the kernel configs I have tried:
> 
> https://gist.github.com/Jajcus/9af258ae55555afb126537e42d697d76
> 
> 
> I suspect some firmware/hardware related thing which triggers the problem.
> 
> 
> BIOS Information
>         Vendor: Insyde Corp.
>         Version: V1.25
>         Release Date: 03/03/2017
> 
> System Information
>         Manufacturer: Acer
>         Product Name: Aspire E5-575
>         Version: V1.25
> 
> Base Board Information
>         Manufacturer: Acer
>         Product Name: Ironman_SK
>         Version: V1.25
> 
> CPU: Intel(R) Core(TM) i5-6267U CPU @ 2.90GHz
> 
> lspci:
> 00:00.0 Host bridge: Intel Corporation Skylake Host Bridge/DRAM
> Registers (rev 09)
> 00:02.0 VGA compatible controller: Intel Corporation Iris Graphics 550
> (rev 0a)
> 00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI
> Controller (rev 21)
> 00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP
> Thermal subsystem (rev 21)
> 00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP
> Serial IO I2C Controller #0 (rev 21)
> 00:16.0 Communication controller: Intel Corporation Sunrise Point-LP
> CSME HECI #1 (rev 21)
> 00:17.0 SATA controller: Intel Corporation Sunrise Point-LP SATA
> Controller [AHCI mode] (rev 21)
> 00:1d.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root
> Port (rev f1)
> 00:1d.2 PCI bridge: Intel Corporation Device 9d1a (rev f1)
> 00:1d.3 PCI bridge: Intel Corporation Device 9d1b (rev f1)
> 00:1f.0 ISA bridge: Intel Corporation Sunrise Point-LP LPC Controller
> (rev 21)
> 00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
> 00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
> 00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
> 02:00.0 Network controller: Qualcomm Atheros QCA9377 802.11ac Wireless
> Network Adapter (rev 31)
> 03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
> RTL8411B PCI Express Card Reader (rev 01)
> 03:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
> 
> 
> Jacek
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
