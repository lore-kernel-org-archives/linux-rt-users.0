From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: SysRQ via ICMP does not work in 3.14
Date: Thu, 10 Jul 2014 04:09:58 +0400
Message-ID: <53BDD9D6.5080508@pavlinux.ru>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:41869 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbaGJAMp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jul 2014 20:12:45 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

- Remote side:

# sysctl -w net.ipv4.icmp_echo_sysrq=305419896

- Local side:

$ ping -c1 -s57 -p1122338862 172.16.0.26
PATTERN: 0x1122338862
PING 172.16.0.26 (172.16.0.26) 57(85) bytes of data.
65 bytes from 172.16.0.26: icmp_req=1 ttl=64 time=0.508 ms

--- 172.16.0.26 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.508/0.508/0.508/0.000 ms


- Remote side: Hello, i'm live!
-- 

                                                          Pavel.
