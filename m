From: =?ISO-8859-15?Q?Niccol=F2_Belli?= <darkbasic@linuxsystems.it>
Subject: Re: [ANNOUNCE] 3.4.1-rt9
Date: Sat, 16 Jun 2012 01:38:09 +0200
Message-ID: <4FDBC761.6030609@linuxsystems.it>
References: <1339076397.7559.4.camel@gandalf.stny.rr.com> <4FD148F6.3040309@linuxsystems.it> <4FD2374E.1010105@linuxsystems.it> <alpine.LFD.2.02.1206150127430.3086@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.linuxsystems.it ([2.119.245.41]:50576 "EHLO
	mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758549Ab2FOXiF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jun 2012 19:38:05 -0400
Received: from [IPv6:2a01:7e00:e001:303:222:faff:fe19:f312] (unknown [IPv6:2a01:7e00:e001:303:222:faff:fe19:f312])
	by mail.linuxsystems.it (Postfix) with ESMTPSA id 2EB99B3E8
	for <linux-rt-users@vger.kernel.org>; Sat, 16 Jun 2012 01:38:03 +0200 (CEST)
In-Reply-To: <alpine.LFD.2.02.1206150127430.3086@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Il 15/06/2012 01:28, Thomas Gleixner ha scritto:
> Just a guess, the area which I would suspect is:
>
>   # CONFIG_PCIEASPM_DEBUG is not set
> -# CONFIG_PCIEASPM_DEFAULT is not set
> -CONFIG_PCIEASPM_POWERSAVE=3Dy
> +CONFIG_PCIEASPM_DEFAULT=3Dy

=46ound it! It is one of the following:

-CONFIG_HOTPLUG_PCI_PCIE=3Dm
+CONFIG_HOTPLUG_PCI_PCIE=3Dy
-CONFIG_HOTPLUG_PCI=3Dm
+CONFIG_HOTPLUG_PCI=3Dy
-CONFIG_HOTPLUG_PCI_ACPI=3Dm
+CONFIG_HOTPLUG_PCI_ACPI=3Dy

Niccol=F2

--=20
http://www.linuxsystems.it
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
