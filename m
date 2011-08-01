From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: quick general performance comparison
Date: Mon, 1 Aug 2011 08:20:11 +0200
Message-ID: <20110801062009.GA23850@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:56571 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589Ab1HAGUQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Aug 2011 02:20:16 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi !

quick general comparison between 3.0.0 (-n) and 3.0.0-rt6 (-t) 
processor: AMD Phenom II X2 550 Processor (32bit install)
Distribution: Debian 6.0.2
lmbech config: default

Network impact is visible, process creation related impact is clearly visible 
and filesystem latency increase in rt is quite high (except for protection 
faults) but the bandwidth impact of rt on VFS is quite small bandwidth on
network (only local communication) still noticable.

hofrat

All runs on both kernels are non-rt tasks only.

                 L M B E N C H  3 . 0   S U M M A R Y
                 ------------------------------------

Basic system parameters
------------------------------------------------------------------------------
Host                 OS Description              Mhz  tlb  cache  mem   scal
                                                     pages line   par   load
                                                           bytes  
--------- ------------- ----------------------- ---- ----- ----- ------ ----
debian    Linux 3.0.0-n       i686-pc-linux-gnu 3107    48   128 3.2300    1
debian    Linux 3.0.0-n       i686-pc-linux-gnu 3107    48   128 3.2400    1
debian    Linux 3.0.0-n       i686-pc-linux-gnu 3107    48   128 3.3900    1
debian    Linux 3.0.0-n       i686-pc-linux-gnu 3107    48   128 3.4000    1
debian    Linux 3.0.0-n       i686-pc-linux-gnu 3107    48   128 3.2300    1
debian    Linux 3.0.0-n       i686-pc-linux-gnu 3107    48   128 3.3900    1
debian    Linux 3.0.0-n       i686-pc-linux-gnu 3107    48   128 3.3900    1
debian    Linux 3.0.0-n       i686-pc-linux-gnu 3107    48   128 3.3900    1
debian    Linux 3.0.0-n       i686-pc-linux-gnu 3107    48   128 3.4000    1
debian    Linux 3.0.0-n       i686-pc-linux-gnu 3107    48   128 3.3800    1
debian  Preempt 3.0.0-t       i686-pc-linux-gnu 3107    48   128 3.2100    1
debian  Preempt 3.0.0-t       i686-pc-linux-gnu 3107    48   128 3.2200    1
debian  Preempt 3.0.0-t       i686-pc-linux-gnu 3107    48   128 3.3900    1
debian  Preempt 3.0.0-t       i686-pc-linux-gnu 3107    48   128 3.4000    1
debian  Preempt 3.0.0-t       i686-pc-linux-gnu 3107    48   128 3.2000    1
debian  Preempt 3.0.0-t       i686-pc-linux-gnu 3107    48   128 3.2500    1
debian  Preempt 3.0.0-t       i686-pc-linux-gnu 3107    48   128 3.2600    1
debian  Preempt 3.0.0-t       i686-pc-linux-gnu 3107    48   128 3.3800    1
debian  Preempt 3.0.0-t       i686-pc-linux-gnu 3107    48   128 3.2300    1
debian  Preempt 3.0.0-t       i686-pc-linux-gnu 3107    48   128 3.3800    1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
debian    Linux 3.0.0-n 3107 0.11 0.18 0.65 1.56 2.56 0.25 1.02 92.4 258. 583.
debian    Linux 3.0.0-n 3107 0.11 0.18 0.65 1.57 2.55 0.25 1.03 93.6 257. 582.
debian    Linux 3.0.0-n 3107 0.11 0.18 0.64 1.62 2.55 0.25 1.03 92.6 258. 581.
debian    Linux 3.0.0-n 3107 0.11 0.18 0.65 1.57 2.50 0.24 1.03 93.1 257. 582.
debian    Linux 3.0.0-n 3107 0.11 0.18 0.64 1.57 2.50 0.24 1.02 92.7 259. 583.
debian    Linux 3.0.0-n 3107 0.11 0.18 0.64 1.59 2.55 0.25 1.03 93.0 256. 584.
debian    Linux 3.0.0-n 3107 0.11 0.18 0.64 1.58 2.50 0.25 1.04 93.0 259. 585.
debian    Linux 3.0.0-n 3107 0.11 0.18 0.64 1.57 2.50 0.25 1.07 92.7 256. 583.
debian    Linux 3.0.0-n 3107 0.11 0.18 0.64 1.60 2.56 0.25 1.02 91.6 255. 585.
debian    Linux 3.0.0-n 3107 0.11 0.18 0.64 1.58 2.52 0.25 1.02 92.9 257. 584.
debian  Preempt 3.0.0-t 3107 0.12 0.19 1.56 3.77 2.64 0.38 1.79 153. 398. 874.
debian  Preempt 3.0.0-t 3107 0.12 0.19 1.59 3.78 2.58 0.38 1.80 154. 402. 873.
debian  Preempt 3.0.0-t 3107 0.12 0.19 1.58 3.80 2.66 0.38 1.79 151. 401. 875.
debian  Preempt 3.0.0-t 3107 0.12 0.19 1.57 3.85 2.58 0.38 1.86 154. 403. 875.
debian  Preempt 3.0.0-t 3107 0.12 0.19 1.54 3.76 2.58 0.38 1.76 155. 402. 878.
debian  Preempt 3.0.0-t 3107 0.12 0.19 1.55 3.81 2.58 0.37 1.79 154. 398. 876.
debian  Preempt 3.0.0-t 3107 0.12 0.19 1.59 3.89 2.58 0.38 1.85 153. 401. 875.
debian  Preempt 3.0.0-t 3107 0.12 0.19 1.57 3.90 2.58 0.38 1.78 158. 404. 882.
debian  Preempt 3.0.0-t 3107 0.12 0.19 1.56 3.81 2.58 0.38 1.75 154. 398. 870.
debian  Preempt 3.0.0-t 3107 0.12 0.19 1.56 3.90 2.58 0.38 1.79 154. 404. 876.

Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr  
                          bit   add    mul    div    mod   
--------- ------------- ------ ------ ------ ------ ------ 
debian    Linux 3.0.0-n 0.3200 0.3200 0.1000   16.4 9.3200
debian    Linux 3.0.0-n 0.3200 0.3200 0.1000   16.4 9.3200
debian    Linux 3.0.0-n 0.3200 0.3200 0.1000   16.4 9.3200
debian    Linux 3.0.0-n 0.3200 0.3200 0.1000   16.4 9.3200
debian    Linux 3.0.0-n 0.3200 0.3200 0.1000   16.4 9.3200
debian    Linux 3.0.0-n 0.3200 0.3200 0.1000   16.4 9.3200
debian    Linux 3.0.0-n 0.3200 0.3200 0.1000   16.4 9.3200
debian    Linux 3.0.0-n 0.3200 0.3200 0.1000   16.4 9.3200
debian    Linux 3.0.0-n 0.3200 0.3200 0.1000   16.4 9.3200
debian    Linux 3.0.0-n 0.3200 0.3200 0.1000   16.4 9.3200
debian  Preempt 3.0.0-t 0.3200 0.3200 0.1000   16.4 9.3300
debian  Preempt 3.0.0-t 0.3200 0.3200 0.1000   16.4 9.3300
debian  Preempt 3.0.0-t 0.3200 0.3200 0.1000   16.4 9.3300
debian  Preempt 3.0.0-t 0.3200 0.3200 0.1000   16.4 9.3300
debian  Preempt 3.0.0-t 0.3200 0.3200 0.1000   16.4 9.3300
debian  Preempt 3.0.0-t 0.3200 0.3200 0.1000   16.4 9.3300
debian  Preempt 3.0.0-t 0.3200 0.3200 0.1000   16.4 9.3300
debian  Preempt 3.0.0-t 0.3200 0.3200 0.1000   16.4 9.3300
debian  Preempt 3.0.0-t 0.3200 0.3200 0.1000   16.4 9.3300
debian  Preempt 3.0.0-t 0.3200 0.3200 0.1000   16.4 9.3300

Basic uint64 operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS int64  int64  int64  int64  int64  
                         bit    add    mul    div    mod   
--------- ------------- ------ ------ ------ ------ ------ 
debian    Linux 3.0.0-n  0.330        0.1900   28.3   31.2
debian    Linux 3.0.0-n  0.330        0.1900   28.3   31.2
debian    Linux 3.0.0-n  0.330        0.1900   28.3   31.2
debian    Linux 3.0.0-n  0.330        0.1900   28.3   31.2
debian    Linux 3.0.0-n  0.330        0.1900   28.3   31.2
debian    Linux 3.0.0-n  0.330        0.1900   28.3   31.2
debian    Linux 3.0.0-n  0.330        0.1900   28.3   31.2
debian    Linux 3.0.0-n  0.330        0.1900   28.3   31.2
debian    Linux 3.0.0-n  0.330        0.1900   28.3   31.2
debian    Linux 3.0.0-n  0.330        0.1900   28.3   31.2
debian  Preempt 3.0.0-t  0.330        0.1900   28.4   31.2
debian  Preempt 3.0.0-t  0.330        0.1900   28.3   31.2
debian  Preempt 3.0.0-t  0.330        0.1900   28.4   31.2
debian  Preempt 3.0.0-t  0.330        0.1900   28.3   31.2
debian  Preempt 3.0.0-t  0.330        0.1900   28.3   31.2
debian  Preempt 3.0.0-t  0.330        0.1900   28.4   31.2
debian  Preempt 3.0.0-t  0.330        0.1900   28.3   31.2
debian  Preempt 3.0.0-t  0.330        0.1900   28.3   31.2
debian  Preempt 3.0.0-t  0.330        0.1900   28.4   31.2
debian  Preempt 3.0.0-t  0.330        0.1900   28.4   31.2

Basic float operations - times in nanoseconds - smaller is better
-----------------------------------------------------------------
Host                 OS  float  float  float  float
                         add    mul    div    bogo
--------- ------------- ------ ------ ------ ------ 
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7400 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4300
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4300
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4300
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4300
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200

Basic double operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS  double double double double
                         add    mul    div    bogo
--------- ------------- ------  ------ ------ ------ 
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7400 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian    Linux 3.0.0-n 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200
debian  Preempt 3.0.0-t 1.2900 1.2900 7.7500 7.4200

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
debian    Linux 3.0.0-n 2.5900 2.6500 2.6800 3.0100 3.1200 3.02000 4.69000
debian    Linux 3.0.0-n 2.6600 2.5500 2.6800 2.9100 3.2500 2.92000 4.61000
debian    Linux 3.0.0-n 2.6100 2.6000 2.6700 3.0200 3.1400 3.03000 4.91000
debian    Linux 3.0.0-n 2.5700 2.6100 2.6800 2.9300 3.2600 2.99000 4.89000
debian    Linux 3.0.0-n 2.6000 2.6300 2.6100 2.9800 3.2000 2.99000 4.58000
debian    Linux 3.0.0-n 2.5700 2.5800 2.7100 3.0100 3.2000 3.02000 4.77000
debian    Linux 3.0.0-n 2.5800 2.6100 2.6300 3.0100 3.1600 2.97000 4.57000
debian    Linux 3.0.0-n 2.5900 2.6300 2.6900 2.9700 3.2500 2.97000 4.53000
debian    Linux 3.0.0-n 2.6600 2.5700 2.6300 2.9500 3.2100 2.95000 4.87000
debian    Linux 3.0.0-n 2.6000 2.5800 2.6400 2.9900 3.4000 2.97000 4.87000
debian  Preempt 3.0.0-t 2.5500 2.6200 2.5900 2.9200 3.1300 2.95000 4.54000
debian  Preempt 3.0.0-t 2.5800 2.6600 2.6700 2.9300 3.0600 2.94000 4.39000
debian  Preempt 3.0.0-t 2.7000 2.7700 2.6100 2.9800 3.2400 2.96000 4.59000
debian  Preempt 3.0.0-t 2.6900 2.6600 2.5800 2.9400 3.0600 2.92000 4.45000
debian  Preempt 3.0.0-t 2.6200 2.6000 2.6500 2.9300 3.2900 2.93000 5.00000
debian  Preempt 3.0.0-t 2.6200 2.5300 2.6000 2.8900 3.2000 2.92000 4.82000
debian  Preempt 3.0.0-t 2.6300 2.6600 2.6300 2.9700 3.2600 2.98000 4.83000
debian  Preempt 3.0.0-t 2.6100 2.6500 2.6000 2.9500 3.0300 2.93000 4.72000
debian  Preempt 3.0.0-t 2.7000 2.6000 2.5600 2.9400 3.1500 2.95000 4.78000
debian  Preempt 3.0.0-t 2.6700 2.6200 2.5600 2.9100 3.0600 2.96000 4.64000

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
debian    Linux 3.0.0-n 2.590 6.463 6.79  10.7  14.0  15.0  18.1  20.
debian    Linux 3.0.0-n 2.660 6.496 6.61  10.7  13.7  14.9  18.0  20.
debian    Linux 3.0.0-n 2.610 6.446 6.75  10.6  13.7  14.8  17.9  20.
debian    Linux 3.0.0-n 2.570 6.726 6.69  10.6  13.8  14.9  18.2  20.
debian    Linux 3.0.0-n 2.600 6.593 6.77  10.7  13.7  15.0  18.0  20.
debian    Linux 3.0.0-n 2.570 6.538 6.70  10.7  13.9  15.1  18.1  20.
debian    Linux 3.0.0-n 2.580 6.526 6.68  10.7  13.8  15.1  18.3  20.
debian    Linux 3.0.0-n 2.590 6.531 6.71  10.7  13.8  14.9  18.1  20.
debian    Linux 3.0.0-n 2.660 6.564 6.73  10.5  13.7  14.9  17.9  20.
debian    Linux 3.0.0-n 2.600 6.439 6.72  10.8  13.7  15.0  18.3  20.
debian  Preempt 3.0.0-t 2.550 7.123 14.4  14.7  18.2  19.2  21.9  36.
debian  Preempt 3.0.0-t 2.580 7.080 14.8  14.8  18.6  19.3  22.4  36.
debian  Preempt 3.0.0-t 2.700 7.056 14.5  14.4  18.3  19.2  22.1  36.
debian  Preempt 3.0.0-t 2.690 7.236 14.6  14.8  18.4  19.3  22.1  36.
debian  Preempt 3.0.0-t 2.620 7.033 14.4  14.6  18.3  19.0  21.8  36.
debian  Preempt 3.0.0-t 2.620 7.067 14.6  14.9  18.5  19.4  22.2  36.
debian  Preempt 3.0.0-t 2.630 7.053 14.3  14.6  18.1  19.2  22.1  36.
debian  Preempt 3.0.0-t 2.610 7.372 14.3  14.8  18.2  19.2  22.0  36.
debian  Preempt 3.0.0-t 2.700 6.972 14.6  14.8  18.2  19.2  22.1  36.
debian  Preempt 3.0.0-t 2.670 7.079 14.9  14.7  18.2  19.1  22.0  36.

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
debian    Linux 3.0.0-n 6.9226 5.5950   23.9   11.1  2579.0 0.393  1424.2 1.446
debian    Linux 3.0.0-n 6.8022 5.4339   25.3   11.1  2694.0 0.377 0.77620 1.426
debian    Linux 3.0.0-n 6.8779 5.5801   24.8   11.4  2714.0 0.357 0.77260 1.448
debian    Linux 3.0.0-n 6.7684 5.5525   27.0   11.3  2728.0 0.366 0.78100 1.444
debian    Linux 3.0.0-n 6.7976 5.2953   27.4   11.3  2684.0 0.356 0.78030 1.396
debian    Linux 3.0.0-n 6.7756 5.4633   24.5   11.3  2718.0 0.399 0.78070 1.446
debian    Linux 3.0.0-n 6.8474 5.4416   24.7   11.2  2730.0 0.347 0.77210 1.444
debian    Linux 3.0.0-n 6.8108 5.4842   24.9   11.4  2727.0 0.389 0.78010 1.447
debian    Linux 3.0.0-n 6.8424 5.4441   24.4   11.3  2729.0 0.331 0.78270 1.442
debian    Linux 3.0.0-n 6.8154 5.4317   26.1   11.7  2695.0 0.358 0.77060 1.442
debian  Preempt 3.0.0-t   15.7   15.9   54.8   28.8  3924.0 0.315 1.02360 1.454
debian  Preempt 3.0.0-t   15.8   16.1   55.4   28.5  3916.0 0.155 0.99050 1.447
debian  Preempt 3.0.0-t   15.7   16.2   56.0   28.4  3920.0 0.172 0.99970 1.457
debian  Preempt 3.0.0-t   15.9   16.4   55.5   28.8  3895.0 0.269 1.00730 1.454
debian  Preempt 3.0.0-t   16.0   17.6   55.3   28.9  3890.0 0.232 1.01080 1.454
debian  Preempt 3.0.0-t   16.0   16.3   55.3   29.1  3892.0 0.190 0.99140 1.455
debian  Preempt 3.0.0-t   20.7   16.5   56.2   29.5  328.2K 0.184 0.98930 1.456
debian  Preempt 3.0.0-t   15.9   16.1   55.8   28.8  3886.0 0.229 0.98370 1.456
debian  Preempt 3.0.0-t   16.0   16.1   55.6   28.8  3848.0 0.257 1.01380 1.446
debian  Preempt 3.0.0-t   15.9   16.3   71.2   28.6  3812.0 0.223 0.98900 1.455

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
debian    Linux 3.0.0-n 1272 1935 1248 2375.6 3674.9 1096.0 1122.2 3787 1466.
debian    Linux 3.0.0-n 1258 1883 1282 2540.3 3686.4 1096.4 1120.8 3756 1463.
debian    Linux 3.0.0-n 1268 1925 1264 2488.1 3778.8 1095.6 1121.8 3788 1463.
debian    Linux 3.0.0-n 1283 1872 1282 2536.9 3689.4 1096.1 1121.0 3786 1460.
debian    Linux 3.0.0-n 1307 1911 1265 2488.1 3778.2 1095.7 1121.3 3758 1464.
debian    Linux 3.0.0-n 1288 1908 1275 2483.2 3778.8 1096.0 1121.3 3712 1464.
debian    Linux 3.0.0-n 1270 1927 1273 2412.1 3777.8 1095.6 1121.1 3757 1459.
debian    Linux 3.0.0-n 1262 1901 1260 2424.8 3779.3 1095.9 1121.5 3752 1464.
debian    Linux 3.0.0-n 1283 1910 1277 2472.3 3687.5 1096.0 1121.3 3757 1463.
debian    Linux 3.0.0-n 1290 1881 1262 2484.3 3778.3 1095.9 1121.4 3749 1459.
debian  Preempt 3.0.0-t 1085 1632 1125 2498.0 3761.4 1093.8 1117.7 3681 1453.
debian  Preempt 3.0.0-t 1088 1689 1131 2454.8 3678.0 1093.2 1117.7 3738 1456.
debian  Preempt 3.0.0-t 1106 1722 1102 2483.6 3764.5 1093.1 1117.7 3773 1454.
debian  Preempt 3.0.0-t 1082 1696 1124 2490.0 3676.5 1093.4 1117.6 3731 1452.
debian  Preempt 3.0.0-t 1096 1640 1140 2464.6 3761.4 1094.3 1118.5 3776 1453.
debian  Preempt 3.0.0-t 1104 1689 1147 2502.4 3676.0 1093.2 1117.5 3746 1454.
debian  Preempt 3.0.0-t 1103 1713 1127 2488.5 3675.0 1093.7 1117.7 3773 1454.
debian  Preempt 3.0.0-t 1105 1670 1125 2524.1 3676.2 1093.6 1118.8 3737 1453.
debian  Preempt 3.0.0-t 1093 1675 1126 2494.0 3674.8 1093.3 1117.8 3771 1458.
debian  Preempt 3.0.0-t 1113 1696 1141 2470.5 3768.7 1094.0 1118.8 3741 1457.

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
------------------------------------------------------------------------------
Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Guesses
--------- -------------   ---   ----   ----    --------    --------    -------
debian    Linux 3.0.0-n  3107 0.9650 4.9310        34.3       104.7
debian    Linux 3.0.0-n  3107 0.9650 4.9310        33.5       104.5
debian    Linux 3.0.0-n  3107 0.9650 4.9300        33.5       107.3
debian    Linux 3.0.0-n  3107 0.9650 4.9300        33.5       107.0
debian    Linux 3.0.0-n  3107 0.9650 4.9300        34.3       105.9
debian    Linux 3.0.0-n  3107 0.9650 4.9310        34.3       107.6
debian    Linux 3.0.0-n  3107 0.9650 4.9310        34.3       105.8
debian    Linux 3.0.0-n  3107 0.9650 4.9300        34.3       106.7
debian    Linux 3.0.0-n  3107 0.9650 4.9310        34.3       107.2
debian    Linux 3.0.0-n  3107 0.9650 4.9310        33.5       108.0
debian  Preempt 3.0.0-t  3107 0.9650 4.9330        33.6       106.3
debian  Preempt 3.0.0-t  3107 0.9650 4.9340        33.6       105.6
debian  Preempt 3.0.0-t  3107 0.9650 4.9330        34.4       104.8
debian  Preempt 3.0.0-t  3107 0.9650 4.9330        33.6       107.7
debian  Preempt 3.0.0-t  3107 0.9650 4.9350        33.6       104.2
debian  Preempt 3.0.0-t  3107 0.9650 4.9340        33.5       105.1
debian  Preempt 3.0.0-t  3107 0.9650 4.9340        33.5       104.3
debian  Preempt 3.0.0-t  3107 0.9650 4.9330        33.6       104.6
debian  Preempt 3.0.0-t  3107 0.9650 4.9340        33.5       104.1
debian  Preempt 3.0.0-t  3107 0.9650 4.9330        34.3       103.2
