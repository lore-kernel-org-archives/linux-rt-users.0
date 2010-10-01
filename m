From: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Subject: segmentation question
Date: Fri, 1 Oct 2010 17:38:26 -0400
Message-ID: <AANLkTinfuURBV9-4=OhgojKWpRZh8QdPSVkeay71wm=D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Kernel-newbies <kernelnewbies@nl.linux.org>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49240 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab0JAVi1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Oct 2010 17:38:27 -0400
Received: by gxk9 with SMTP id 9so1306084gxk.19
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Oct 2010 14:38:27 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

      I am developing segmentation for my kernel. In that process I
choose to divide whole memory in to fixed size segments. So a 4GB
memory can be divided in to 8192 segments. So I initialize segment
descriptors in to the GTD withs segments base address and limit. Here
base address are 0,0x10000,0x20000,..... and limit is 64kb always for
every segment. For a task if I choose a segment to assign, I will
place the index of that segment descriptor in to CS, DS. Now when
process generates address to put on address bus, then it will do
computation from logical address to linear address.
After processor picks logical address, it chooses segment descriptor
and adds this 32-bit logical address to segment base address to
generate linear address. Now my question is, if my segment size is
64kb, how is that 32-bit offset is added to segment base address,
which is not right. It should only consider 16-bit offset to add to
base to generate linear address. How can I tell to my processor to
choose only 16-bit offset. Does processor drives offset bit width
automatically based on limit defined in segment descriptor.

Any insight in to this will help me. please clarify my doubt. Waiting
for you reply.

Regards,
Sri.

-- 
Regards,
Sri.
