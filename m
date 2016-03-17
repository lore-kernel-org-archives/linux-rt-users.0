From: Matt Campbell <mcampbell@izotope.com>
Subject: struct wait_queue_Head_t to struct swait_head warning
Date: Thu, 17 Mar 2016 11:26:04 -0400
Message-ID: <CAMDowVWB-ZBQ6ZEcGWohuZbVwzkSJALGKHf1-bP6OxenkAcROQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34544 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031417AbcCQP0F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 11:26:05 -0400
Received: by mail-yw0-f177.google.com with SMTP id h129so104166498ywb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2016 08:26:04 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I'm using the RT patch on an IMX6 using the Freescale kernel
(3.14.52). I'm using a Broadcom wireless chip using the BCMDHD driver.
I get the following warning when compiling:

drivers/net/wireless/bcmdhd/dhd_pno.c: In function '_dhd_pno_get_for_batch':
drivers/net/wireless/bcmdhd/dhd_pno.c:1377:23: warning: passing
argument 1 of 'waitqueue_active' from incompatible pointer type
  if (waitqueue_active(&_pno_state->get_batch_done.wait))
                       ^
In file included from include/linux/mmzone.h:9:0,
                 from include/linux/gfp.h:5,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from drivers/net/wireless/bcmdhd/include/linuxver.h:42,
                 from drivers/net/wireless/bcmdhd/include/linux_osl.h:212,
                 from drivers/net/wireless/bcmdhd/include/osl.h:44,
                 from drivers/net/wireless/bcmdhd/dhd_pno.c:29:
include/linux/wait.h:102:19: note: expected 'struct wait_queue_head_t
*' but argument is of type 'struct swait_head *'
 static inline int waitqueue_active(wait_queue_head_t *q)
                   ^
drivers/net/wireless/bcmdhd/dhd_pno.c: In function 'dhd_pno_event_handler':
drivers/net/wireless/bcmdhd/dhd_pno.c:1827:25: warning: passing
argument 1 of 'waitqueue_active' from incompatible pointer type
   if (!waitqueue_active(&_pno_state->get_batch_done.wait)) {
                         ^
In file included from include/linux/mmzone.h:9:0,
                 from include/linux/gfp.h:5,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from drivers/net/wireless/bcmdhd/include/linuxver.h:42,
                 from drivers/net/wireless/bcmdhd/include/linux_osl.h:212,
                 from drivers/net/wireless/bcmdhd/include/osl.h:44,
                 from drivers/net/wireless/bcmdhd/dhd_pno.c:29:
include/linux/wait.h:102:19: note: expected 'struct wait_queue_head_t
*' but argument is of type 'struct swait_head *'
 static inline int waitqueue_active(wait_queue_head_t *q)
                   ^

It looks like this is due 'struct completion' changing to using the
simple waitqueue in the RT patch. When looking at the rest of the RT
patch it looks like cases like this are handled by changing the API to
use the simple wait calls for these (for example usb/gadget/f_fs.c). I
was able to get rid of the warning by switching from
'waitqueue_active' to 'swaitqueue_active'. I'm not fully knowledge
about the possible effects, so I was hoping someone could let me know
if this is or isn't a good solution. I know this isn't mainline, but I
would appreciate any help to point me in the right direction.

Thanks,
~Matt
