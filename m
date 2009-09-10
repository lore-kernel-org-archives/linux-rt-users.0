From: =?ISO-8859-15?Q?J=FCrgen_Mell?= <mell@hedrich-winders.com>
Subject: Problem with function select on kernel  2.6.29.6-rt23
Date: Thu, 10 Sep 2009 12:47:52 +0200
Message-ID: <4AA8D958.5000508@hedrich-winders.com>
Reply-To: mell@hedrich-winders.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dispoweb.ifw.uni-hannover.de ([130.75.23.4]:51135 "EHLO
	ketschua.hedrich-winders.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752982AbZIJK4A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Sep 2009 06:56:00 -0400
Received: from [192.168.157.2] (unknown [192.168.157.2])
	by ketschua.hedrich-winders.com (Postfix) with ESMTP id AA6931692D5
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Sep 2009 12:47:52 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have an application which connects via a network socket to a server=20
running on the same machine (IP 127.0.0.1) This application uses the=20
function 'select' to wait for new data from the server or until a two=20
seconds timeout. This works well until there is network traffic on the=20
external network interfaces (eth* or WLAN). When there is network=20
traffic on the external interfaces, the select function does not wait=20
anymore but it returns with a return code of zero, indicating not data=20
available on the socket. This happens nearly immediately (after 8 to 9=20
microseconds) and not after the specified two seconds interval. The=20
timeout parameter of select is updated accordingly (it shows eg. 1 s=20
999991 us).
Up to now I could not test this with another kernel but I will try to d=
o=20
it this afternoon. Are there any known problems with select? Is there=20
any way to circumvent this?

Any help would be greatly appreciated!

        J=FCrgen

--=20
J=FCrgen Mell (Software-Entwicklung)       mell@hedrich-winders.com
Tel.:  +49-511-762-18226                 http://www.hedrich-winding.com
=46AX :  +49-511-762-18225
Mobil: +49-160-7428156
-----------------------------------------------------------------------=
-----
HEDRICH winding systems GmbH
An der Universit=E4t 2 (im PZH)
D-30823 Garbsen (GERMANY)
-----------------------------------------------------------------------=
-----
Gesch=E4ftsf=FChrer: Karsten Adam
Handelsregister: Wetzlar, HRB 4768
Steuernr.: 020/235/20110                 USt-IdNr.: DE 258258279
-----------------------------------------------------------------------=
-----=20


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
