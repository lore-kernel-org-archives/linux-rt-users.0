From: Tim Sander <tim01@iss.tu-darmstadt.de>
Subject: Re: Embedded programmer new to rt-linux, what distribution / release to start with?
Date: Tue, 5 Jan 2010 21:46:12 +0100
Message-ID: <201001052146.12882.tim01@iss.tu-darmstadt.de>
References: <1fb80681001041440k3769b02aodf9358d72465e2fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx141.hrz.tu-darmstadt.de ([130.83.156.236]:47133 "EHLO
	lnx141.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755508Ab0AEUyn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jan 2010 15:54:43 -0500
Received: from lnx503.hrz.tu-darmstadt.de (lnx503.hrz.tu-darmstadt.de [130.83.156.232])
	by lnx141.hrz.tu-darmstadt.de (8.14.2/8.13.8) with ESMTP id o05KrnKl014395
	for <linux-rt-users@vger.kernel.org>; Tue, 5 Jan 2010 21:53:49 +0100
	(envelope-from tim01@iss.tu-darmstadt.de)
Received: from mailserver3.hrz.tu-darmstadt.de (lnx504.hrz.tu-darmstadt.de [130.83.156.233])
	by lnx503.hrz.tu-darmstadt.de (8.14.2/8.14.2/HRZ/PMX) with ESMTP id o05KlAkq014501
	for <linux-rt-users@vger.kernel.org>; Tue, 5 Jan 2010 21:47:10 +0100
	(envelope-from tim01@iss.tu-darmstadt.de)
Received: from [213.157.9.123] (helo=ligeia.localnet)
	by mailserver3.hrz.tu-darmstadt.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <tim01@iss.tu-darmstadt.de>)
	id 1NSGJ4-0002OU-3O
	for linux-rt-users@vger.kernel.org; Tue, 05 Jan 2010 21:47:10 +0100
In-Reply-To: <1fb80681001041440k3769b02aodf9358d72465e2fe@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Cameron

Just my 2 cents:
> I am mainly interested in off the shelf kernels and distributions, and
> so far think RH or SUSE  would probably be my best bet.
As far as i know the guys from Pengutronix are maintaining some 
-rt Kernels for Debian. Haven't tested them but i guess they fit your needs.

> My goal at this point is to determine which distribution and release
> to start with.
The textonly debian installer is quite neat with DM, MD etc functionality just 
download a netboot installer cd and your ready to go. 

Don't know anything about the other questions concerning RH or Suse.

Tim 
