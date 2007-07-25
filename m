From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: v2.6.22.1-rt5
Date: Tue, 24 Jul 2007 21:36:21 -0400
Message-ID: <200707242136.21457.gene.heskett@gmail.com>
References: <20070724120436.GA14466@elte.hu>
 <200707241156.03149.gene.heskett@gmail.com> <20070724191027.GA13268@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:39645 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758897AbXGYBgv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 21:36:51 -0400
In-reply-to: <20070724191027.GA13268@elte.hu>
Content-disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@gmail.com> wrote:
>> The above stanza still needs some tlc.  I built a 2.6.22.1-rt6 (rt5
>> wouldn't build) using the same old config that a make oldconfig didn't
>> fuss about, but the reboot never completed, see the attached, heavily
>> smunched camera shot of the panic.
>>
>> Kinda looks like hda/sda confusion, with rt3 (this boot), its hda*,
>> what is it now?  fstab or kernel config error?
>
>yeah, as long as your filesystems are created with a proper label, all
>that you need to do is to change all 'hda' to 'sda' in the new kernel's
>/etc/grub.conf entry. (or enable the old IDE code in the .config, under
>CONFIG_IDE)
>
>	Ingo

Changing the "root (hd0,0)" to (sd0,0) failed.  Grub can't parse the (sd0,0).

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
WHERE CAN THE MATTER BE
	Oh, dear, where can the matter be
	When it's converted to energy?
	There is a slight loss of parity.
	Johnny's so long at the fair.
