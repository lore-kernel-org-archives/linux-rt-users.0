From: Simon Sudler <Simon.Sudler@iis.fraunhofer.de>
Subject: Re: 3.0.4-rt14 "shutdown -h now" hangs on x86 32b
Date: Tue, 04 Oct 2011 09:52:43 +0200
Message-ID: <4E8ABB4B.6000204@iis.fraunhofer.de>
References: <4E89FBDE.7080406@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070706090608010308030506"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay04-haj2.antispameurope.com ([83.246.65.54]:52154 "EHLO
	relay04-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754184Ab1JDIAU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Oct 2011 04:00:20 -0400
In-Reply-To: <4E89FBDE.7080406@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070706090608010308030506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Darren,

i had the same problem on a Z530 with all RT kernels 3.0. I didn't=20
search for the reason, however the problem went away when i used the=20
"Intel Atom" at the "Processor family" option.

Best regards,
Simon

On 03.10.2011 20:15, Darren Hart wrote:
> I have a couple of platforms (including the n450 dev board from kernel
> summit) where an x86 32b build of 3.0.4-rt14 fails to shutdown with
> "shutdown -h now". reboot works properly, and shutdown works with
> maxcpus=3D1 (otherwise the n450 has 2 hardware threads).
>
> The last messages to hit the console are:
>
> e1000e 0000:04:00.0: PCI INT A disabled
> ehci_hcd 0000:00:1d.7: PCI INT A disabled
> ehci_hcd 0000:00:1a.7: PCI INT C disabled
>
> I am booting from a USB stick. If I install to a SATA connected SSD, th=
e
> shutdown still fails, but I don't see the "INT X disabled" messages.
>
> Has anyone run into this with a known workaround? Any thoughts on where=

> to start digging?
>
> .config attached.


--------------070706090608010308030506
Content-Type: text/x-vcard; charset=utf-8;
 name="Simon_Sudler.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="Simon_Sudler.vcf"

begin:vcard
fn:Simon Sudler
n:Sudler;Simon
org;quoted-printable:Fraunhofer IIS;Nachrichten=3DC3=3DBCbertragung - Com=
munications Department
adr:;;Am Wolfsmantel 33;Erlangen;;91058;Deutschland
email;internet:Simon.Sudler@iis.fraunhofer.de
title:Dipl.-Ing.
tel;work:+49 9131 776-6309
tel;fax:+49 9131 776-6399
tel;cell:+49 160 5323753
url:www.iis.fraunhofer.de
version:2.1
end:vcard


--------------070706090608010308030506--
