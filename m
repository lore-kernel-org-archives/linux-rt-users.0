From: Ayyappa Ch <ayyappa.ch.linux@gmail.com>
Subject: Need information how to verify Linux RT Kernel latency
Date: Mon, 20 Apr 2015 10:49:53 +0530
Message-ID: <CAPyr0yJr+3gKwA4VeNNsaCAqxcJVUhxksGc3au5Bi8iAs7c6mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34451 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbbDTFTy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Apr 2015 01:19:54 -0400
Received: by qkgx75 with SMTP id x75so175293035qkg.1
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Apr 2015 22:19:53 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello All,

I would like to run my system regressively to verify latency of RT
Kernel. From OSADL side i got to know that only running Cyclic test is
not enough to verify RT linux latency of the system.

I got below infor from
"https://www.osadl.org/Single-View.111+M52212cb1379.0.html"

***********************************************************************=
****************
# cyclictest -a -t -n -p99 -i100 -d50
560.44 586.11 606.12 211/1160 3727
T: 0 (18617) P:99 I:100 C:1011846111 Min:  2 Act:  4 Avg:  5 Max: 39
T: 1 (18618) P:98 I:150 C: 708641019 Min:  2 Act:  5 Avg: 11 Max: 57

The test was running on a linux-2.6.24.7-rt15 kernel in parallel with
repeated loops of "hackbench 25","ls -Ral /", and flood ping from
outside. After having executed more than one billion cyclictest loops,
the internal worst-case latency is still only 39 =C2=B5s!
***********************************************************************=
********************

I am able to run Cyclic test . But I am not sure how to run "hackbench
25","ls -Ral /", and flood ping from outside. Can anyone help how to
run these .

Thanks and regards,
Ayyappa.Ch
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
