From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.12.5 CRASH/FREEZE
Date: Fri, 20 Dec 2013 15:10:08 +0100
Message-ID: <20131220141008.GE10249@linutronix.de>
References: <52A9CC77.20904@linaro.org>
 <52AA1CC0.30307@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Pavel Vasilyev <pavel@pavlinux.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52AA1CC0.30307@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Pavel Vasilyev | 2013-12-13 00:29:52 [+0400]:

>On startup, if USB webcam (uvcvideo) attached in usb-hole
>
>NMI backtrace for cpu 0
>CPU: 0 PID: 35 Comm: irq/43-xhci_hcd Not tainted 3.12.5-plx #6

> [<c13aa59c>] xhci_queue_isoc_tx_prepare+0x39c/0x950
> [<c139d35f>] xhci_urb_enqueue+0x22f/0x540
> [<c1375745>] usb_hcd_submit_urb+0x65/0x280
> [<c13777a0>] usb_submit_urb+0x170/0x3a0
> [<c13e1ee8>] uvc_video_complete+0xb8/0xd0
> [<c1374625>] __usb_hcd_giveback_urb+0x45/0xa0
> [<c1374bd8>] usb_hcd_giveback_urb+0x38/0xf0
> [<c13a84cf>] handle_tx_event+0x3af/0xda0
> [<c13a9082>] xhci_irq+0x1a2/0x6c0
> [<c13a95aa>] xhci_msi_irq+0xa/0x10
> [<c1084c31>] irq_forced_thread_fn+0x21/0x70
> [<c1085046>] irq_thread+0x106/0x220
> [<c1057110>] kthread+0xd0/0xe0
> [<c15083b7>] ret_from_kernel_thread+0x1b/0x28

This looks like uvc is resubmitting the URB on completion. Nothing
unusual. Howver it seems that then CPU gets stuck in
xhci_queue_isoc_tx_prepare() for some reason. Could you try map c13aa59c
to the source line? Something like
  addr2lin -e xhci-hcd.ko -i c13aa59c

should do the trick but of the module of this trace.
What does the -plx stand for in localversion? Do you have any custom
patches on your kernel?

Sebastian
