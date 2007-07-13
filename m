From: John Sigler <linux.kernel@free.fr>
Subject: Counting CPU_CLK_UNHALTED on an idle system
Date: Fri, 13 Jul 2007 14:33:09 +0200
Message-ID: <46977105.6020604@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org,
	oprofile-list@lists.sourceforge.net
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Sender: oprofile-list-bounces@lists.sourceforge.net
Errors-To: oprofile-list-bounces@lists.sourceforge.net
List-Id: linux-rt-users.vger.kernel.org

[ Note: cross-posted to linux-rt-users and oprofile-list ]

Hello,

The x86 Performance Monitoring Event "CPU_CLK_UNHALTED" is defined as:
Number of cycles during which the processor is not halted.

IIUC, when the CPU is in the HALT state, CPU_CLK_UNHALTED should not 
increment, right? When Linux has nothing to do, it executes HLT.

http://lxr.linux.no/source/arch/i386/kernel/process.c#L101

I set up OProfile to sample EIP every 200000 CPU_CLK_UNHALTED cycles on 
an idle system. I was expecting a very small number of samples, since 
CPU_CLK_UNHALTED should not increment (most of the time).

I ran the daemon 5 minutes on a idle system

# opreport -l
CPU: PIII, speed 1266.7 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a 
unit mask of 0x00 (No unit mask) count 200000
samples    %      symbol name
1868484  99.4914  cpu_idle
    4560   0.2428  (oprofiled)
     727   0.0387  ip_route_input
     457   0.0243  acpi_ev_asynch_execute_gpe_method
     454   0.0242  ip_route_output_slow
     286   0.0152  dma_free_coherent
     280   0.0149  ip_route_input_slow
     273   0.0145  acpi_ex_opcode_6A_0T_1R
     220   0.0117  __acpi_nmi_disable
     130   0.0069  Dta1xxRxProcessStatusFlags
      94   0.0050  Dta1xxTxProcessStatusFlags
      93   0.0050  (bash)
      85   0.0045  Dta1xxIsr
      79   0.0042  intel_machine_check
      56   0.0030  sys_olduname
      51   0.0027  Dta1xxPeriodicIntHandler

cpu_idle breakdown:

   c0100e70 1        5.4e-05
   c0100e71 1        5.4e-05
   c0100e78 1        5.4e-05
   c0100e88 1        5.4e-05
   c0100e8a 1        5.4e-05
   c0100e97 4        2.1e-04
   c0100ea8 1868475  99.9995

cpu_idle objdump:

c0100ea6:       fb                      sti
c0100ea7:       f4                      hlt
c0100ea8:       eb 0b                   jmp    c0100eb5

(If an interrupt is used to resume execution after a HLT instruction, 
the saved instruction pointer points to the instruction following the 
HLT instruction.)

oprofiled collected 1878300 samples. In other words, the system received 
1878300 NMIs. (5 * 60 * 1.2667e9) / 1878300 = 202316 cycles between NMI

Seems like CPU_CLK_UNHALTED increments every cycle.

Perhaps HLT does not put my CPU in the HALT state?

Did I miss something?

Regards.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
