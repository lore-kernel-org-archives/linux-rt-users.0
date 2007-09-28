From: Juergen Beisert <jbe@pengutronix.de>
Subject: Network hangs when rt-preempt patch is applied
Date: Fri, 28 Sep 2007 12:13:34 +0200
Message-ID: <200709281213.34994.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:53213 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753790AbXI1KNs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Sep 2007 06:13:48 -0400
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>)
	id 1IbCqo-0002kA-QX
	for linux-rt-users@vger.kernel.org; Fri, 28 Sep 2007 12:13:45 +0200
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I'm trying to find out if this is an MPC5200B related driver problem or
RT-Preempt related one: Under some network (nmap, nc) load the network =
dies on
my target.

Target (PowerPC) runs 2.6.23-rc8 plus patch-2.6.23-rc8-rt1.

Sometimes it survives the nmap, but mostly it dies immediately. Here it=
 was
successfull in the first nmap run, but dies on the second one:

-----------------------------------------------------------------------=
-------

jbe@octopus:~/bla$ nmap -v 192.168.23.226

Starting Nmap 4.20 ( http://insecure.org ) at 2007-09-28 11:58 CEST
Initiating Parallel DNS resolution of 1 host. at 11:58
Completed Parallel DNS resolution of 1 host. at 11:58, 0.04s elapsed
Initiating Connect() Scan at 11:58
Scanning 192.168.23.226 [1697 ports]
Discovered open port 22/tcp on 192.168.23.226
Discovered open port 23/tcp on 192.168.23.226
Completed Connect() Scan at 11:58, 0.08s elapsed (1697 total ports)
Host 192.168.23.226 appears to be up ... good.
Interesting ports on 192.168.23.226:
Not shown: 1695 closed ports
PORT   STATE SERVICE
22/tcp open  ssh
23/tcp open  telnet

Nmap finished: 1 IP address (1 host up) scanned in 0.226 seconds
jbe@octopus:~/bla$ nmap -v 192.168.23.226

Starting Nmap 4.20 ( http://insecure.org ) at 2007-09-28 11:58 CEST
Initiating Parallel DNS resolution of 1 host. at 11:58
Completed Parallel DNS resolution of 1 host. at 11:58, 0.04s elapsed
Initiating Connect() Scan at 11:58
Scanning 192.168.23.226 [1697 ports]
Discovered open port 22/tcp on 192.168.23.226
Discovered open port 23/tcp on 192.168.23.226
>>>>>>>>>>>>>>> [hangs a while] <<<<<<<<<<<<<<<<<<<<<<<
Completed Connect() Scan at 11:58, 11.90s elapsed (1697 total ports)
Host 192.168.23.226 appears to be up ... good.
Interesting ports on 192.168.23.226:
Not shown: 1443 closed ports, 252 filtered ports
PORT   STATE SERVICE
22/tcp open  ssh
23/tcp open  telnet

Nmap finished: 1 IP address (1 host up) scanned in 12.045 seconds
jbe@octopus:~/bla$ nmap -v 192.168.23.226

Starting Nmap 4.20 ( http://insecure.org ) at 2007-09-28 12:10 CEST
Note: Host seems down. If it is really up, but blocking our ping probes=
, try -P0
Nmap finished: 1 IP address (0 hosts up) scanned in 2.010 seconds

-----------------------------------------------------------------------=
-------

In this case an "ifconfig eth0 down; ifconfig eth0 up" on my target
reactivates the network and I can restart the nmap test. And it fails a=
gain
and again.

Any idea?

Juergen
--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
