From: "Javier Sanz" <jsanza@gmail.com>
Subject: Re: 2.6.26.3-rt2
Date: Thu, 21 Aug 2008 20:01:24 +0200
Message-ID: <a3d4028e0808211101h6769d698s71e045f486cfec56@mail.gmail.com>
References: <1219339082.22710.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.184]:5735 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbYHUSBZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Aug 2008 14:01:25 -0400
Received: by rn-out-0910.google.com with SMTP id k40so81881rnd.17
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Aug 2008 11:01:24 -0700 (PDT)
In-Reply-To: <1219339082.22710.16.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I got the following problem compiling linux 2.6.23-rt2:

 <....>
  CC      kernel/ns_cgroup.o
  CC      kernel/utsname.o
  CC      kernel/user_namespace.o
  CC      kernel/pid_namespace.o
  CC      kernel/res_counter.o
  CC      kernel/stop_machine.o
  CC      kernel/audit.o
  CC      kernel/auditfilter.o
  CC      kernel/auditsc.o
  CC      kernel/audit_tree.o
  CC      kernel/kprobes.o
  CC      kernel/softlockup.o
  CC      kernel/seccomp.o
  CC      kernel/rcupreempt.o
  CC      kernel/rcupreempt-boost.o
kernel/rcupreempt-boost.c: In function '__rcu_preempt_unboost':
kernel/rcupreempt-boost.c:328: error: too few arguments to function
'rcu_trace_boost_unboost_called'
make[1]: *** [kernel/rcupreempt-boost.o] Error 1
make: *** [kernel] Error 2

am i doing something wrong ?

thank you
