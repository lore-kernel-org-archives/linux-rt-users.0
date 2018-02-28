Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx1.esisar.grenoble-inp.fr ([195.220.37.33]:52998 "EHLO
        mx1.esisar.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933018AbeB1VQ2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Feb 2018 16:16:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTP id AA14D80196C
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Feb 2018 22:11:27 +0100 (CET)
Received: from mx1.esisar.grenoble-inp.fr ([127.0.0.1])
        by localhost (mx1.esisar.grenoble-inp.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sZhF5G-N8RqF for <linux-rt-users@vger.kernel.org>;
        Wed, 28 Feb 2018 22:11:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTP id 1F4DE801999
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Feb 2018 22:11:27 +0100 (CET)
Received: from mx1.esisar.grenoble-inp.fr ([127.0.0.1])
        by localhost (mx1.esisar.grenoble-inp.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mEI17Mj7VcdU for <linux-rt-users@vger.kernel.org>;
        Wed, 28 Feb 2018 22:11:26 +0100 (CET)
Received: from zimbra.esisar.grenoble-inp.fr (zimbra.esisar.grenoble-inp.fr [172.21.100.135])
        by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id E887980196C
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Feb 2018 22:11:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTP id 5AC4828A2B3A
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Feb 2018 22:11:12 +0100 (CET)
Received: from zimbra.esisar.grenoble-inp.fr ([127.0.0.1])
        by localhost (zimbra.esisar.grenoble-inp.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WsK-WBfJsq3W for <linux-rt-users@vger.kernel.org>;
        Wed, 28 Feb 2018 22:11:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTP id 69B5A28A2B3B
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Feb 2018 22:11:11 +0100 (CET)
Received: from zimbra.esisar.grenoble-inp.fr ([127.0.0.1])
        by localhost (zimbra.esisar.grenoble-inp.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9VpyV0lt4IxH for <linux-rt-users@vger.kernel.org>;
        Wed, 28 Feb 2018 22:11:11 +0100 (CET)
Received: from zimbra.esisar.grenoble-inp.fr (localhost [127.0.0.1])
        by zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTP id 2931628A2B3A
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Feb 2018 22:11:11 +0100 (CET)
Date: Wed, 28 Feb 2018 22:11:10 +0100 (CET)
From: Yann le Chevoir <yann.le-chevoir@etu.esisar.grenoble-inp.fr>
Reply-To: Yann le Chevoir <yann.le-chevoir@grenoble-inp.org>
Message-ID: <1431882400.9091188.1519852270876.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
Subject: RT-thread on cpu0 affects performance of RT-thread on isolated cpu1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_Part_9091184_585091920.1519852270870"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

------=_Part_9091184_585091920.1519852270870
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I am an engineering student and I try to proof that a 4000Hz hard real-time
application can run on an ARM board rather than on a more powerful machine.

I work with an IMX6 dual-core and PREEMPT_RT patch-4.1.38-rt46.
I expected that my 4000Hz thread will perform better if it is the only one
on core1, so I put the boot argument isolcpus=3D1 and bound my thread to cp=
u1.

With the isolcpus=3D1, note that it remains these processes on core1:

   PID    PSR    RTPRIO    CMD
   16     1      99        [migration/1]
   17     1      -         [rcuc/1]
   18     1      1         [ktimersoftd/1]
   19     1      -         [ksoftirqd/1]
   20     1      99        [posixcputmr/1]
   21     1      -         [kworker/1:0]
   22     1      -         [kworker/1:0H]

I tried several permutations in my kernel configuration and boot args
(rcu_nocbs is an example) and none affected the results I describe below.


I use a script to stress Linux. I expected that only cpu0 will be stressed
as cpu1 is isolated. But it has an impact on thread on cpu1 too.
I think it is normal.


First, as I draw it (in red) on =E2=80=9Cexpected_behavior.png=E2=80=9D, I =
expected much less
variations in the Latency and especially the Execution time.
(My thread always does the same thing).

How can we explain so much time variations? As I said, I tried to deactivat=
e
all interrupts on cpu1 (rcu and others processes above) but I am not very
familiar with that.



Then, I am even more surprised when, trying to debug that, I decided to put
another thread on core0 and it improved the behavior of the thread on core1=
!


My application looks like:

main(){

     create a first 4000Hz thread (thread1), prio =3D 99, cpu =3D 1
     /*cpu1 is isolated*/

     create a second 4000Hz thread (thread0), prio =3D 98, cpu =3D 0
     /*To create this thread (cpu0) improves the performance of
      *the other thread (cpu1)!*/

     start both threads

     while(1){
          print_stat();
     }

}

thread1(){

     struct timespec start, stop, next, interval =3D 250us;

     /* Initialization of the periodicity */
     clock_gettime(CLOCK_REALTIME, &next);
     next +=3D interval;

     while(1){
          /*Releases at specified rate*/
          clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &next, NULL);
          /*Get time to check jitter and execution time*/
          clock_gettime(CLOCK_REALTIME, &start);
          do_job();
          /*Get time to check execution time*/
          clock_gettime(CLOCK_REALTIME, &stop);
          do_stat(); //jitter =3D start-next; exec_time =3D stop-start
          next +=3D interval;
     }

}

thread0(){
    struct timespec next, interval =3D 250us;

     /* Initialization of the periodicity */
     clock_gettime(CLOCK_REALTIME, &next);
     next +=3D interval;

     while(1){
          /*Releases at specified rate*/
          clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &next, NULL);
          usleep(100);
          /****************************************************************
           * Without sleeping 100us, only the Latency of the other thread *
           * (on cpu1) is improved.                                       *
           * Sleeping 100us in this new 4000Hz thread (cpu0) improved     *
           * the execution time of the other thread (on cpu1)...          *
           ****************************************************************=
/
          next +=3D interval;
     }

}

As you can see in =E2=80=9Cbackground_thread_on_core_0.png=E2=80=9D, the La=
tency and the
Execution time (of the thread on core1) are improved (in comparison with
=E2=80=9Cno_background_thread.png=E2=80=9D) when there is a new 4000Hz thre=
ad on cpu0
AND when this thread does something...

I tried a lot of permutations and I do not understand:
- If the new thread (cpu0) is at 5000Hz (>4000Hz), then observations
  are the same (performance of the thread on cpu1 improves)
- If the new thread is at 2000HZ (<4000Hz), then there is no improvement...

- If the new thread (4000Hz on cpu0) does something (even sleeping enough
  time), then the Execution time of the thread on cpu1 improves.
- If the new thread does nothing (or do too few stuff), then, ONLY the
  Latency of the thread on cpu1 is improved...

Do you have any experience with that, any idea to debug?
I wonder if the scheduler or the clock tick are bound to cpu0 and if it
can play a role in the responsiveness of the thread on cpu1 (isolated one).

Thanks,

Regards,

Yann
------=_Part_9091184_585091920.1519852270870
Content-Type: image/png; name=background_thread_on_core_0.png
Content-Disposition: attachment; filename=background_thread_on_core_0.png
Content-Transfer-Encoding: base64

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
------=_Part_9091184_585091920.1519852270870
Content-Type: image/png; name=expected_behavior.png
Content-Disposition: attachment; filename=expected_behavior.png
Content-Transfer-Encoding: base64

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
25CtWlrzapreLObTOE3TPJrXXabGuctTv8YZ69czz63f/4746/C3Q+O1Xj1uVfPFttWE1ivuum2Z
Wp+WZ/vmx8TdX+PP07UtQNFU5Y465P6coTeshcZhc/Sb6c1fZ2dnwc7Y28hE4+17Rv32NjL1a37N
o0+jaRqnT3X2FjNbj9svth7jrjf2HXe97na426phrdu2VW8407iY0HpF49ztcPfff0ObjbMYGo3v
ixuQQ8fPWGhDr4hKGDk/Z18butCOvln6zbq4v6eVPlUqVb9K6UbDVjI29h5xK5Vqmsa57/vW9zSs
TtuySJBXy9B6VCp2t8Gfxx8OrcPfDn1nkUCv5rH1uMvx+esRd5y/TK1L71J3v2Pj/Jj2xS3VzvF/
WvZNz8XBf132YV06FsdKq1S5YxZKbvNT0tEJINS5lHi0H0qASjouS4o6mVh3dHTUjrfp5+fnbQJz
KWm5yXcdsXVo2LbDuAnU7V+Hu15bZt96+uKGMNrQy0RCxw2UyMvlJhk/4SiRnpyctP85cDu/lJmT
PDeZ1IZK4utKjRswCYtSACqR+3PG2stj4zE8/WaLBLIcitM8autV267agtW5NKw2YJfapt22YGsr
dtkyRdviLkPz+seUv73+cGgdts0mtM+hca6+7/jT1a9xrtC4lLgBOfxjbJsooQMjs/baUGdUxa5S
rT5V9X56enrjamyNV/uwtf+qGl3Vom5JWOPs++o0rBKqVbkvkvHV922eEH/bXFrWwcHB1XL0qSps
fa6ra72r0nb1xQ2YjGViRwX0c1qXIlYSj40vVfMv/3TVxSyS07KvLO5vFurESspuCVQlSH+c5lOJ
U+NDJWXROE3TPH7pVP3utFCJVuu1eUSf7jaIO4+W429H6DuhcS5/veJ+x/+++t15JTROUuKGm0r9
exqTjh/rxsJV7hXRBT05P2fsqXBTelpc6Mri0BW7KnXxykdgGPw9xeWeh4dElTsmK3abUGg8Jx9g
OPw9lYmEjkma8j2/ALAJJHRUwa9m9xM+980Cw+HvqUwkdEyOn6x5yhUAkNBRka5SOm1+wHD4eyoT
CR2TRukcAC6R0GfKfwlLTOp829J3MVwswdPmF0dswohLHLEpEwkdAIAK8GCZiuQ80KDv4TElPlwm
9WI4LpoDMBYeLDOC0CsdRc9z1jT9KPoMPTt6m/MAAJBilgldL53Qyy18Sqh6UYOS6/HxcfuCBg27
iX+b8yCuq9QdmkabXxyxCSMuccSmTLNK6ErkKg3rbVAheuOSbsfQp966pPn39/dvvHVqm/PgWt/F
cF3W+S4ATMWsErpKw2dnZ20XolK7kqtLw25V+DbnwXC4bzaO2IQRlzhiU6ZZJXRVa1sX40/TsF8N
vs15cFvKRW5cCAdgbmZ7UZzPEmkoyZ6fn7f925wHw6LaPY720DDiEkdsykRCX7Lk6peQNby7u9v2
b3OeVekaAbdz//DU3/WHmDt928O+oednmGF3WHLmZ3iew/45d0yzvQ9dgVdbuiVX0biTk5O2rd3o
IjV11ra9zXlyaZm13ofulrBzqtNX/R4ArCLnPDw0SugOXejhJ1MlWDfpbnMeDItqdwA1I6E7dJX5
0dFReyuZkq0+/avRtzkPsA1uNSKuEZc4YlMmErpDpWNVgyvB6iEv+tSwWy2/zXmwPr+anVI6gFrx
LPeKqO3G9P2sOW3oMnY7+jpt4X4Spy0dwNByzr+bQgm9MjqQ+D/aTSRwAJtWwrmXhI6gUt6wJkNX
k1PtfhPtoWHEJY7YlImEDgBABUjomJRVq8+pdo/judxhxCWO2JSJhA4AQAVI6JgF2vziiE0YcYkj
NmXKSui6V1oPQNE91LpfWpfp61PDeiCKpgNTwIVxAGqTdB+6krgeS2rJW5/W6YUi1imh61PJXd/B
dg35LHcp5Xnu69yD7uJ+dACbNuaz3HsTuhK4lcCVwPsooSv5K7lTYt8uEnq/IZcFAL4xE3pvlbuS
s0rbKclcNJ+V6IFShNr8qHa/RHtoGHGJIzZl6k3oqYnct+r3AABAvuyr3FWdEOuUxK2EjnHYb4Gb
7L5Zv5qdUjr3FMcQlzhic1sJ597shK43gu3u7jaHh4dtvzr1a5xVz+uT14COQ203Y7XfAMBclXDu
zU7oSth2FbtdMGfjLJHrkzYWlMQ9HrkY7ib+VsOISxyxKVN2Qj89PW2TuE/j7Kp2m64r3oHSUe0O
oAbZCV1V66Hb0dxxlsi5MA6loM0vjtiEEZc4YlOmlarcj46O2mp1JW6771zjNE3Dqnbf399ffgMo
DxfHAahNdkJXsj4+Pm6T997eXtupX+M0TSV1lcyV5IFSpLT5zTWp0x4aRlziiE2ZshO6KHGrJH52
dtZ2Viq3aUrmVLejdFwcB6AmSc9yxzToHsjUn3Ouj34N8UvmJHoAq8o5Dw9tpRK6qtV1Jbs9SMa9
wh0AAGxfdkJXdfqDBw/aJK5+derXONrNUaquNr+5l8hpDw0jLnHEpkwrJXQ9GU4XwimRq1O/xpHQ
MTSuPgeANNkJvevBMpoGlCjnvtm5/SeCe4rDiEscsSlTdkLverCMpgGbwsVqABCXndBVvd71YBmg
RH1tfvrPwr/95/991amUPpeSOu2hQB2yE7ruM7c2dPfBMhpn96IDU/P//v7usu+Skrr0JXVL/HNJ
/gDKtdZ96CqdCw+RKUON96G7iXKTVe5+Qpe//S//YdmXjmYBYN6Kvg/dqtVDnQmNQ13c5I44Suoz
9PZps/Ppt82vy8FrvzbffrrTPH27HMy27vcxN70J3arVUzugRLQTx20vNpcJSiUYt/v029upcFt+
/fbTZmeGGfPt00Xsg/8JwZT1JnRVHeR0qMeYj3stgarP/Sp0G+d3Lkrp3Z68uXnO+PGrj5ZTsC2f
fbeI/Y9fNUS+LtkXxQFTtM59s7HEXYsi7in+9dvm051Pm6vC+o1hlezV/7Z5elWyd+Zt+aX/p82N
cne7vOvpT99ezn/32fumefmwHXddU5CzrMV2/HU5PmqN7W51fP/Wfl2ObkvgN2oeLtdj+xibHt4O
rX+x3m+fBqahJElt6KugPX0c9geJ7ao12W/NR181r180zbNHqgZeJJdHz5rmxevmuvD+vnl295vm
418uS/W/aN6714nl7dO7zbNP3lyV+n958VPz8KpKeZGQ7mp5vyynv2mab35oPv9R891TlUE73moK
updl22bL+rr5+dnLdkrMy4erbvcl9/tvnizi8M9X326eLv4v9vrqu/eal99cfvezL54svvjn68T7
6w/N9+/vNV9+HiqTK5kHtuNG4l6sd7Hbb9rp3zWfLcfiWgnn3t6ErlvRdFtaaoLWfJqfW9jGYX+Q
uKmvnfjf/d9fln3DmFK1+7avL3j50EqBN0t7H331dfPk/bPm0aePmmfNi+a1VxX/5M2PVwm+nbf5
qfmrsteilPrNy3vNiz9dp5nLZX3f/KDpb//cvFzM/fXV8j5rvotVN/ctq02M3rLeLJJnh5W3e8n9
fpuof/rrMuHf3I+PPv+yuff+56Y9kj/7YrGel82fl8H99Yfvm/f3vmzC+fxyn958522HbefSkzck
8i4lnHt7E7o9Fc59brseJKPxSt761LDG2zwSepocMCWhW9lw23VyTiud3GxDd5PEZXJ8//598+Tr
lPbd983PV/8PUwne/Y/Cw0U6c9z7uEn/NTuW9cvPi6nrytjuHu1Fffbdu8+cbfusuSykK6P/2vzw
fUdMg/t0t/n4nrudmIKkNnQrodunErhK4LqqXZ/21Dh3PqAk22gnnurFcavGxhKJyx/O87Z5+vCn
5sWLRdnyYUo77b3m46ssvShhXv0nwbrrkm1jJdckHcu6+/FirevK2O4ub582d599cv39X17c2LbP
/rQYVrX7sgT+Rax4HdynX5qf37vbiSnIuihOpW+3dK6DSJ9WSrfSOYBLtV7xvl7iDnv7dFE6ffJ1
89VXf2pe3HvZPPRuJ3v58PqCsF+//aZ5aVXIH33efLmY/5ubV5tdW1Y/X09f/MfBbae+qsJe6FvW
R/+++cRdli5Ke9jXhr7idmd6+89uCX3Blv/o++b9ky/i1eXL+dx439hOTEZWQgemalvtxFO8OC4n
NqFSea6bbejLK68Xpc2HL60d96Pmq9cqXX5z44ruJ2++bn6+e/mdtmR61X68mP/HX5ovv797Y7nX
91l/1nx3eTXacto3zcevL7972e78rLm7GH95BXjmsu7+3HztlYxvute8ePNl8/1K293js++aN08W
iXj5vW8+frH4j4vro+bzL+9dNmFEi+ei7XjTPFle7a/u7vdfNr9wW9vkrPXoV5RFf4ipP2fqY13H
fvyrW8JdJ1kqafVVLYfazFe9WM4vmZec6FNio2MrxWZOJ5dXYf/89UXjXLcFFCnnPDw0SuiYhSLu
tS5UV2ysxNZHJzDKBsC4SOjABkz1AjnXuKVyALlI6JiFbd9rPSV+bMorlauNd/vV7RwzccSmTCR0
YEOmVkqneh2YNhJ6B92Gp9vyfLpNT9N08tNn6CE6Q82DYdCGHqdnSZDIb+OYiSM2ZUpK6EpqqV0t
dF/96enpcuiaku6DBw/aBHx8fNzcuXOnHXb3fah5MH2l38aWksiFEjlQvqTb1pR0QsktZOp/+Erk
BwcHy6GmOTs7a5OtUSw0rPmMxqmzJ+QNNU8unZxT489ta7cNeduaq8Rb2Ejk/VKOmbkiNnE55+Gh
JZXQVZpUKVKU4LSxsW7qlFC1j+pC9B8b/8UzGnary4eaB9sVSt61Pc9dJ5uUZF7L3zMwJ8lt6H7y
qZVKzdbF+NM07FeVDzUPhjFmaaKUEjmJPA8l0DhiU6asi+KslD5XlmxDifj8/LztH2oe3K6qrsU2
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
------=_Part_9091184_585091920.1519852270870
Content-Type: image/png; name=no_background_thread.png
Content-Disposition: attachment; filename=no_background_thread.png
Content-Transfer-Encoding: base64

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
A4/nbyBYooawAAAAAElFTkSuQmCC
------=_Part_9091184_585091920.1519852270870--




