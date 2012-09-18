From: Vincent Bossier <vincent.bossier@gmail.com>
Subject: Missing interrupts with RT
Date: Tue, 18 Sep 2012 10:51:17 +0200
Message-ID: <CAJU=c_V4F_fXSHNJqkBL_N-WXSqAuoHrxe3cnxP_Q6q9dJFYyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47823 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab2IRIvR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Sep 2012 04:51:17 -0400
Received: by pbbrr13 with SMTP id rr13so10629591pbb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Sep 2012 01:51:17 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I recently upgraded my RT validation system to a new board and it
seems to sometimes miss interrupts. I don't see this behavior on my
old RT validation system and the problem only appears with the RT
patch. See appendix B for the details of the two systems.

The test consists in looping through the following operations (see
appendix A for code excerpts):

1. Store command in sysfs attribute
2. Write command through VME bus (through PCI(-X)<->VME bridge) to a mailbox
3. Wait for command  ACK interrupt from mailbox
4. Wait for response READY interrupt from mailbox
5. Read response from mailbox
6. Update sysfs attribute and notify

The problem is that sometimes (typically 1 every 1000), operation 3
times out and I never get the message "got vector ack" from the
interrupt handler. It looks like my interrupt handler is never called.
Could someone give me some hints to narrow down the problem ? How
could I instrument the code or what events could I trace to find the
root cause ?

Trials that I made so far with the old (O) and the new (N) system:

OK   0 + 3.0.23-rt38

OK   N + 3.4.10

Fail N + 3.0.31-rt51
Fail N + 3.4.10-rt18
Fail N + 3.4.10-rt18 + maxcpus=1
Fail N + 3.4.10-rt18 + UP

Note: since wake_up family is not more callable from interrupt context
with the RT patch, I was not able to test the IRQF_NO_THREAD option.

Thank you for any help,

Vincent

Appendix A
----------

Operations 3 and 4 involve an interrupt handler that wakes up a
sleeping process. The involved code looks like this. The device uses
the VME framework and therefore inherits from VME device. The
interrupt handler registers itself through the VME framework as well.

static int pmac_wait_ack(struct pmac *card, signed long timeout)
{
    int ret = wait_event_timeout(card->ack_queue, card->ack_flag != 0,
                     timeout);
    card->ack_flag = 0;

    return ret;
}

static int pmac_wait_ready(struct pmac *card, signed long timeout)
{
    int ret = wait_event_timeout(card->ready_queue, card->ready_flag != 0,
                     timeout);
    card->ready_flag = 0;

    return ret;
}

static void pmac_int_handler(int level, int statid, void *data)
{
    struct pmac *card = (struct pmac*)data;

    if (statid == card->int_vector) {
        dev_dbg(&card->vdev->dev, "got vector ready (%02X)\n", statid);
        card->ready_flag = 1;
        wake_up(&card->ready_queue);
    }
    else if (statid == card->int_vector - 1) {
        dev_dbg(&card->vdev->dev, "got vector ack (%02X)\n", statid);
        card->ack_flag = 1;
        wake_up(&card->ack_queue);
    }
    else {
        dev_dbg(&card->vdev->dev, "got invalid vector %02X\n", statid);
    }
}

Appendix B
----------

Old system - GE VMIVME-7805
Pentium-M mono-processor with 256 MiB
Excerpt from /proc/cpuinfo
model name    : Mobile Intel(R) Pentium(R) 4 - M CPU 1.70GHz
IDT Universe IID PCI<->VME bridge (vme_ca91cx42)
The bridge uses the 8259 old-style interrupts from the ICH4 chipset.
Excerpt from /proc/interrupts
 11:         40    XT-PIC-XT-PIC    uhci_hcd:usb2, vme_ca91cx42

New system - Emerson iVME7210
i7 based quad-core machine with 4GiB memory
Excerpt from /proc/cpuinfo (4X)
model name    : Intel(R) Core(TM) i7 CPU       U 620  @ 1.07GHz
IDT Tsi148 PCI-X<->VME bridge (vme_tsi148)
Excerpt from /proc/interrupts
 18:          1          0          1          1   IO-APIC-fasteoi   vme_tsi148
