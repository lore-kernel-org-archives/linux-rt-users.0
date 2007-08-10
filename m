From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: megaraid_sas problems on rt
Date: Fri, 10 Aug 2007 10:21:57 -0300
Message-ID: <20070810132157.GG3375@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:42379 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759970AbXHJNWG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 09:22:06 -0400
Received: by wr-out-0506.google.com with SMTP id 36so49710wra
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Aug 2007 06:22:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

      I've been experiencing problems with the megaraid_sas driver under
some simple stress testing when using the rt patch. Simply running:

cat /dev/sda > /dev/null

will after a while make the driver start sending this to the logs:

sd 0:2:0:0: [sda] megasas: RESET -285224 cmd=28 retries=0
megasas: [ 0]waiting for 2 commands to complete
megasas: [ 5]waiting for 2 commands to complete
megasas: [10]waiting for 2 commands to complete


Till it gets to:

megasas: cannot recover from previous reset failures
sd 0:2:0:0: scsi: Device offlined - not ready after error recovery

And then no more I/O goes thru.

This happens with 2.6.21 + patch-2.6.21.5-rt10 and 2.6.23-rc2 +
patch-2.6.23-rc2-rt2, while not happening without the rt patch.

I looked at driver/scsi/megaraid/megaraid_sas.c and as what its
interrupt handler does is to just ack the int to the firmware and
schedule its tasklet I tried using IRQ_NODELAY and it made the problem
go away, after more than 20 hours of stress testing the system doesn't
exhibits the problem.

Ah, of course in the two machines were I tested, both Dell Poweredge
systems, the IRQ used by the cards was not shared with any other device.

I'm trying some ideas, such as making tasklet_schedule, when run from an
interrupt handler routine to run the tasklet action right away, not
waiting for the tasklet kthread to be scheduled, but the problem only
seems to take more time to happen.

Ideas?

- Arnaldo
