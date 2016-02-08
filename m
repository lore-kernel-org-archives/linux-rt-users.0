From: David Aldrich <David.Aldrich@EMEA.NEC.COM>
Subject: Linux RT newbie question
Date: Mon, 8 Feb 2016 12:16:03 +0000
Message-ID: <41302A7145AC054FA7A96CFD03835A0A0BA89C7D@EX10MBX02.EU.NEC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cluster-a.mailcontrol.com ([85.115.52.190]:42897 "EHLO
	cluster-a.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbcBHNGu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Feb 2016 08:06:50 -0500
Received: from mail1.neceur.com (mail1.neceur.com [195.47.207.3])
	by rly31a.srv.mailcontrol.com (MailControl) with ESMTP id u18CG5UD098035
	for <linux-rt-users@vger.kernel.org>; Mon, 8 Feb 2016 12:16:05 GMT
Received: from intmail1.neceur.com (intmail1.neceur.com [172.29.14.11])
	by mail1.neceur.com (8.14.4/8.14.4) with ESMTP id u18CG58N029765
	for <linux-rt-users@vger.kernel.org>; Mon, 8 Feb 2016 12:16:05 GMT
Received: from av1.neceur.com (av1.neceur.com [172.29.14.21])
	by intmail1.neceur.com (8.13.8/8.13.8) with ESMTP id u18CG5XX024212
	for <linux-rt-users@vger.kernel.org>; Mon, 8 Feb 2016 12:16:05 GMT
Received: from av1.neceur.com (unknown [127.0.0.1])
	by IMSVA80 (Postfix) with ESMTP id 15A28296B7A
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Feb 2016 12:16:05 +0000 (GMT)
Received: from EX10CAS02.EU.NEC.COM (unknown [172.29.155.134])
	by av1.neceur.com (Postfix) with ESMTP id 08752296B74
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Feb 2016 12:16:05 +0000 (GMT)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

=46or a new project we need to demonstrate a Linux RT-Kernel=A0running =
on a 'standard' x86 desktop PC.

The question is which distro to use?  I am aware of commercially suppor=
ted embedded distros from Wind River and Monta Vista.  However, as ours=
 is not strictly an embedded target, I wonder if a standard Linux distr=
o + RT kernel patch would be a better choice?

I have done some research and found the Planet CCRMA patches for Fedora=
 and the Pengutronix patches for Debian.

Are there any other distros and patches that I should consider? =20

Any advice on a way forward would be much appreciated.

Best regards

David

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
