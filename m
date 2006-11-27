From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Missing figures in RT_PREEMPT_HOWTO
Date: Mon, 27 Nov 2006 22:13:21 +0100
Message-ID: <456B54F1.3030408@stud.feec.vutbr.cz>
References: <45608487.4020309@gmail.com> <20061119164846.GO18636@pengutronix.de> <45617BD4.7030103@stud.feec.vutbr.cz> <20061122120330.GD18636@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050800020108000309000509"
Cc: Dirk Behme <dirk.behme@googlemail.com>, l.fu@pengutronix.de,
	Juergen Beisert <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from av5.karneval.cz ([81.27.192.12]:57967 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S933644AbWK0VOh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Nov 2006 16:14:37 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20061122120330.GD18636@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------050800020108000309000509
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Robert Schwebel skrev:
> I've ported the changes from the wiki diff output; please send me a diff
> with a correct credit line for the document header. I suppose I've not
> correctly seen who made which changes.

Here's a patch fixing a slight confusion, where the description of 
threaded IRQs seemed to suggest that they're executed either in user or 
kernel context, while the real distinction is interrupt/process context.
It also adds myself to the document header and updates the revhistory.

Michal Schmidt


--------------050800020108000309000509
Content-Type: text/x-patch;
 name="contexts-confusion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="contexts-confusion.patch"

Index: RT-Preempt-HOWTO.docbook
===================================================================
--- RT-Preempt-HOWTO.docbook	(revision 5)
+++ RT-Preempt-HOWTO.docbook	(working copy)
@@ -49,6 +49,15 @@
 	  </affiliation>
 	</collabname>
       </collab>
+      <collab>
+        <collabname>
+          <firstname>Michal</firstname>
+	  <surname>Schmidt</surname>
+	  <affiliation>
+	    <address><email>xschmi00@stud.feec.vutbr.cz</email></address>
+	  </affiliation>
+	</collabname>
+      </collab>
 
     </authorgroup>
 
@@ -63,9 +72,21 @@
 
     <revhistory>
       <revision>
+        <revnumber>1.3</revnumber>
+	<date>2006-11-27</date>
+        <revremark>Clear the userspace/kernel vs. interrupt/process context
+	           confusion; Michal Schmidt</revremark>
+      </revision>
+      <revision>
+        <revnumber>1.2</revnumber>
+	<date>2006-11-22</date>
+        <revremark>Clock Source and Clock Events; Juergen Beisert</revremark>
+      </revision>
+      <revision>
         <revnumber>1.1</revnumber>
 	<date>2006-11-19</date>
-        <revremark>Typos added; patch by Dirk Behme</revremark>
+        <revremark>Typos fixed, IRQ_* flags documented;
+	           Dirk Behme, Michal Schmidt</revremark>
       </revision>
       <revision>
         <revnumber>1.0</revnumber>
@@ -106,7 +127,7 @@
 
   <listitem>
     <para>
-      Making in-kernel locking-primitives (using spinlocks) preemptible though
+      Making in-kernel locking-primitives (using spinlocks) preemptible through
       reimplementation with rtmutexes:
     </para>
     <para>
@@ -133,8 +154,9 @@
     </para>
     <para>
        The RT-Preempt patch treats soft interrupt handlers in kernel thread
-       context, which is represented by a task_struct like a common userspace
-       process. However it is also possible register an IRQ in kernel context.
+       context, which is represented by a task_struct like a common process.
+       However it is also possible register an IRQ handler for immediate
+       execution in interrupt context.
    </para>
   </listitem>
 
@@ -266,8 +288,8 @@
 </itemizedlist>
 
 <para> Further interesting options can be found under the "Kernel
-Hacking" menu entry This menu lists options for system debugging and
-performance measurement. Keep in mind that the debug options may either
+Hacking" menu entry. This menu lists options for system debugging and
+performance measurement. Keep in mind that the debug options may
 increase the kernel size or cause higher latencies. If you do not want
 to debug the kernel or get some automatically produced histograms, make
 sure that you don't activate any unneccessary options here. If you have
@@ -311,13 +333,14 @@
 
 <para>Now have a look at the process list. As mentioned earlier in this
 document, the IRQ handlers are treated by a patched kernel in kernel
-thread context. Single IRQ Handlers are transparently represented by task
-structs like user space tasks. Thus they can be listed or controlled by
+thread context. Single IRQ Handlers are transparently represented by
+task_structs like other tasks. Thus they can be listed or controlled by
 userspace tools. The following figure shows partly a list of running
 processes on a system with a patched kernel.</para>
 
 <para>Note that, in contrast to a non-RT kernel, the interrupt handlers
-are kernel threads here, so they are listed [in square brackets].</para>
+have dedicated threads, so they are listed here like other kernel threads
+[in square brackets].</para>
 
 <figure>
   <title>Checking for Kernel Threads in the Process List</title>
@@ -398,17 +421,17 @@
   </programlisting>
 </figure>
 
-<para> A "N" marks an IRQ which is declared as an hard IRQ and thus
-handled in kernel context. In our example we have IRQ0, IRQ2 and IRQ7
-marked as hard IRQs, which are handled in kernel context. IRQ0 (timer)
+<para> A "N" marks an IRQ which is declared as a hard IRQ and thus
+handled in interrupt context. In our example we have IRQ0, IRQ2 and IRQ7
+marked as hard IRQs, which are handled in interrupt context. IRQ0 (timer)
 and IRQ2 (cascade controller) are set as hard IRQ by the system by
 default. IRQ7 (lpptest) is used for benchmarking interrupt latency time.
 The lpptest comes with the realtime preemption patch. To mark an IRQ as
-hard IRQ, you will have to manipulate the IRQ decription manually. With
+hard IRQ, you will have to manipulate the IRQ description manually. With
 the IRQ status marked as IRQ_NODELAY and the flags of the IRQ action
 marked as IRQF_NODELAY | IRQF_DISABLED the handler of the IRQ will not
 be treated as a kernel thread. Since such an IRQ handler is
-unpreemptable, it's absolutely not recommended to mark an IRQ as hard
+not preemptible, it's absolutely not recommended to mark an IRQ as hard
 IRQ manually while developing your own kernel modules. To change the
 priority of a kernel thread like e.g. an interrupt handler, you can use
 the chrt tool, which is downloadable at <xref linkend="5"/>. With this

--------------050800020108000309000509--
