From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: realtime ethernet
Date: Wed, 3 May 2017 16:33:09 -0500
Message-ID: <20170503213309.GA27055@unpythonic.net>
References: <568ec603-8a01-3726-dd8e-6cf04e055767@numalliance.com>
 <d3ca141e-916f-d7f1-e840-c1a450921f36@numalliance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Ancelot <sancelot@numalliance.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from afk.unpythonic.net ([138.68.55.246]:43565 "EHLO
        afk.unpythonic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdECVdS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 May 2017 17:33:18 -0400
Content-Disposition: inline
In-Reply-To: <d3ca141e-916f-d7f1-e840-c1a450921f36@numalliance.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In LinuxCNC, we are successfully using rt preempt for realtime
networking.  You can find the code in our public git:
https://github.com/LinuxCNC/linuxcnc/blob/master/src/hal/drivers/mesa-hostmot2/hm2_eth.c
(GPL2+ license).  This talks to an FPGA board from Mesa Electronics,
which is running its own embedded realtime software stack.

Depending on the setup, this generally consists of 2 UDP packets
transmitted + 1 packet received, at a repetitive rate between 500Hz and
4kHz, with most users selecting 1kHz as far as we're aware.  The packets
aren't that big overall, without looking I bet it's under 1kB per period
all told.  (so the bandwidth utilization is not high)

On the Linux end we are generally using a dedicated gigabit NIC, and my
testing personally has been with Intel PCI-E nics like 82574L.  Most
users attach a single FPGA board (that board has a 100-megabit NIC) but
it's also possible to attach several boards via a dedicated gigabit
switch.

(The packet data consists of information from a CNC machine such as
motor position and other machine state, and commands to the machine
consist of things like motor torque commands or step waveform frequency
commands; LinuxCNC closes the position loop and performs other machine
logic)

As usual, not all mainboards and NICs are suitable, but we certainly
have success with specific Intel NICs. (and maybe some realteks?)

There are some tunables like RX IRQ coalesce that need to be, er, tuned
but I don't have that info on hand and it looks like it isn't in our
documentation. :(

I wish the tricks like manual ARP pinning and firewall manipulation
weren't necessary, but in our situation they seem to be somewhere
between helpful and necessary.  In particular, needing to ARP the other
NIC is not great for latency.

I've used hm2_eth with a range of RT kernels from 3.2 to 4.9 (usually
debian -rt kernels).

Disclaimer: I was compensated for the work I'm describing here

Jeff
