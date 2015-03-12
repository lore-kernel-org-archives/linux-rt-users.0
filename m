From: Daniel Kasak <d.j.kasak.dk@gmail.com>
Subject: btrfs and linux-rt
Date: Thu, 12 Mar 2015 15:16:24 +1100
Message-ID: <CAF73Y=Qfsw=Yre6d_kP7Vmn+Ln1L4viBVRPksdomdGKVzDu+6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36814 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbbCLEQ0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 00:16:26 -0400
Received: by lbiz11 with SMTP id z11so13351042lbi.3
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Mar 2015 21:16:24 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings.

I've just re-installed Linux on my laptop, and to my horror ... linux-rt is
not compatible with btrfs. I have all my partitions using btrfs now. When
Linux boots, it hangs when mounting the root partition. I've searched
around a little, and found others reporting the same. Are there any plans
to sort out this incompatibility?

Thanks :)

Dan
