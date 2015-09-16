From: Your name <nobelkernel@gmail.com>
Subject: PCI: PCIe endpoint initiating write request to RC
Date: Wed, 16 Sep 2015 12:23:40 +0530
Message-ID: <20150916065338.GA24779@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34538 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbbIPGxq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Sep 2015 02:53:46 -0400
Received: by padhy16 with SMTP id hy16so200477888pad.1
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2015 23:53:46 -0700 (PDT)
Received: from gmail.com ([182.73.114.58])
        by smtp.gmail.com with ESMTPSA id sl7sm25754295pbc.54.2015.09.15.23.53.43
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 23:53:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have a doubt, hope some one would have come across the same,

For a root complex to send data to PCIe endpoints, Then it has to write data
that could hit the BAR region of PCIe endpoints.

For a vice versa, if PCIe endpoint which doesn't has DMA descriptor in it and
it is trying to send data. which address I need to configure? Any
physical address of ram or physical address got for kmalloc or endpoint BAR? 

If PCIe endpoint can access the entire memory does it has a permission to
corrupt the host memory from external. We know linux handle memory
violation for process by memory structure assigned in each task_struct.
But can someone explain me how it been managed for data comming out from
endpoint to Root complex?

Regards
Nobel
