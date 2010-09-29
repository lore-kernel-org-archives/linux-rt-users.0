From: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Subject: Regarding GDT
Date: Wed, 29 Sep 2010 13:28:00 -0400
Message-ID: <AANLkTikBzDcnDgkiv1NxBP-kXyUr00XOa0XThzDJATdK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Kernel-newbies <kernelnewbies@nl.linux.org>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54990 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670Ab0I2R2A (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Sep 2010 13:28:00 -0400
Received: by pzk34 with SMTP id 34so246638pzk.19
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Sep 2010 10:28:00 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

      I have a doubt regarding implementation of segmentation in OS.

      Since GDT is used to implement the segmentation, in that table
you add all segments descriptors dividing the linear address space.
      In a flat model you assign for every descriptor the base as 0x0
and limit as 4GB. This way every DS,CS sees the complete 4GB memory.
      But how is the segment protection implemented. I mean if
segments are not divided with different base address and limit
preventing
      overlapping, there is a possibility of stepping in to other
segment. So, why is the flat model is implemented. Also, If I strictly
implement
      segmentation without paging, then I can have only 8192 segments
of size 64kb for whole 4GB address space. Then I have all the segment
      descriptors in the GDT. Now if some task uses all its complete
segment size, and needs some more space, then is it possible to assign
      another DS segment. If so, how is that accomplished, since we
need to load in DS new index of segment descriptor and keep track of
all
      indexes in to GDT.

      Can anyone explain how above mentioned things can be achieved.
-- 
Regards,
Sri.
