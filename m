From: Jon Masters <jonathan@jonmasters.org>
Subject: PROBLEM: 2.6.33-rt7 crash under KVM
Date: Wed, 17 Mar 2010 23:31:46 -0400
Message-ID: <1268883106.18098.2054.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Folks,

I like to run an RT test kernel under KVM (I am aware of latency issues,
this is just for development). The latest 2.6.33-rt7 kernel has been
crashing on X startup occasionally. I didn't have anything listening to
the virtual serial console before but now have minicom attached to the
host pts, so the next time it falls over I will post the backtrace.

Jon.
