From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge latencies in
 cyclictest
Date: Thu, 22 Sep 2016 12:44:00 +0000
Message-ID: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:38681 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753884AbcIVMoD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Sep 2016 08:44:03 -0400
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
        by imta23.fe.bosch.de (Postfix) with ESMTP id A6DFB15801FE
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Sep 2016 14:44:00 +0200 (CEST)
Received: from SI-MBX1011.de.bosch.com (vsgw22.fe.internet.bosch.com [10.4.98.11])
        by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id 7F55C2380501
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Sep 2016 14:44:00 +0200 (CEST)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I have detected the strange effect, that the igb driver for Intel's Ethernet adapters is causing huge latencies in cyclictest on
a Core i7 PC (64bit) using kernel 4.6.7-rt13.

I run the cyclictest with the following options:
# cyclictest -a -i 100 -d 10 -m -n -t -p 80

The max latencies are really great, all below 5 microseconds (on an idle system, after 1 minute run time of cyclictest).
Of course the 2 minutes run-time of cyclictest is only a rough first estimate.
With this first test there is no igb base NIC configured yet.


In the PC I have also 2 port Ethernet NIC i350 from Intel that uses the igb driver.
Once I configure one of the i350 ports
# ifconfig eth2 up 192.168.100.100
the cyclictest shows directly and reproducibly significant larger max latency values (40 microseconds, using the same conditions).


I did the very same test with kernel version 3.18.27-rt27.
With that version I did not see anything like that.

Also, only the igb driver seems to cause the trouble. I have also an e1000e based NIC in this PC and 
the usage of this driver does not add any significant latency.

Any idea on this?

Thanks for any feedback

Best regards

Mathias

