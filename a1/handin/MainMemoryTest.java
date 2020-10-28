package arch.sm213.machine.student;

import machine.AbstractMainMemory;
import org.junit.Before;
import org.junit.Test;
import org.omg.CORBA.DynAnyPackage.Invalid;

import static org.junit.Assert.*;

public class MainMemoryTest {
     private MainMemory memory;

     @Before
     public void setUp() {
          memory = new MainMemory(16);
     }

     @Test
     public void testLength() {
          // random
          assertEquals(16, memory.length());
          memory = new MainMemory(0);
          assertEquals(0, memory.length());
     }

     @Test
     public void testisAccessAligned() {
          // tests aligned
          assertTrue(memory.isAccessAligned(8,4));
          // tests false
          assertFalse(memory.isAccessAligned(6,7));
          // QUESTION: if length or memory is negative (should i be throwing an exception? can lengths and memory even be negative?)
          // ANSWER: just put a requires clause :-)
//          assertTrue(memory.isAccessAligned(8,-4));
//          assertTrue(memory.isAccessAligned(-8,4));
          // QUESTION: what about testing when memory or length = 0;
          // QUESTION: so what exactly is an int?
     }

     @Test
     public void testBytesToInteger(){
          // edges
          // 0x00000000 - low positive
          // QUESTION: why do i have to cast here... isn't 0x00 or 0xff a byte?
          assertEquals(0, memory.bytesToInteger((byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0x00));
          // 0x7fffffff - high positive
          assertEquals(2147483647, memory.bytesToInteger((byte) 0x7f, (byte) 0xff, (byte) 0xff,(byte) 0xff));
          // 0xffffffff - low negative
          assertEquals(-1, memory.bytesToInteger((byte) 0xff, (byte) 0xff, (byte) 0xff, (byte) 0xff));
          // 0xf0000000 - high negative
          assertEquals(-252645376, memory.bytesToInteger((byte) 0xf0, (byte) 0xf0, (byte) 0xf0, (byte) 0x00));

          // random
          assertEquals(16909060, memory.bytesToInteger((byte) 0x01, (byte) 0x02, (byte) 0x03, (byte) 0x04));
          assertEquals(-247282780, memory.bytesToInteger((byte) 0xf1, (byte) 0x42, (byte) 0xc3, (byte) 0xa4));
     }

     @Test
     public void testIntegerToBytes(){
          byte[] bytes;
          // edges
          // 0 - low positive
          bytes = new byte[] {(byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0x00};
          assertArrayEquals(bytes, memory.integerToBytes(0));
          // 0x7fffffff - high positive
          bytes = new byte[] {(byte) 0x7f, (byte) 0xff, (byte) 0xff, (byte) 0xff};
          assertArrayEquals(bytes, memory.integerToBytes(2147483647));
          // -1 - low negative
          bytes = new byte[] {(byte) 0xff, (byte) 0xff, (byte) 0xff, (byte) 0xff};
          assertArrayEquals(bytes, memory.integerToBytes(-1));
          // -252645376 - high negative
          bytes = new byte[] {(byte) 0xf0, (byte) 0xf0, (byte) 0xf0, (byte) 0x00};
          assertArrayEquals(bytes, memory.integerToBytes(-252645376));

          // random
          bytes = new byte[] {(byte) 0x01, (byte) 0x02, (byte) 0x03, (byte) 0x04};
          assertArrayEquals(bytes, memory.integerToBytes(16909060));
          bytes = new byte[] {(byte) 0xf1, (byte) 0x42, (byte) 0xc3, (byte) 0xa4};
          assertArrayEquals(bytes, memory.integerToBytes(-247282780));
     }

     @Test
     public void testSetWorking() throws AbstractMainMemory.InvalidAddressException {
          byte[] bytes = {00, 00, 00 ,00};
          try {
               memory.set(0,bytes);
          } catch (AbstractMainMemory.InvalidAddressException e) {
               fail();
          }
     }

     @Test
     public void testSetNegAddress() throws AbstractMainMemory.InvalidAddressException {
          byte[] bytes = {00, 00, 00 ,00};
          try {
               memory.set(-1,bytes);
               fail("Exception should have been thrown.");
          } catch (AbstractMainMemory.InvalidAddressException e) {
               e.printStackTrace();
          }
     }

     @Test
     public void testSetTooLong() throws AbstractMainMemory.InvalidAddressException {
          byte[] bytes = {00, 00, 00 ,00};
          try {
               memory = new MainMemory(4);
               memory.set(4,bytes);
               fail("Exception should have been thrown.");
          } catch (AbstractMainMemory.InvalidAddressException e) {
               e.printStackTrace();
          }
     }

     @Test
     public void testSetNotAligned() throws AbstractMainMemory.InvalidAddressException {
          byte[] bytes = {00, 00, 00 ,00};
          try {
               memory = new MainMemory(4);
               memory.set(3,bytes);
               fail("Exception should have been thrown.");
          } catch (AbstractMainMemory.InvalidAddressException e) {
               e.printStackTrace();
          }
     }

     @Test
     public void testGetWorking() throws AbstractMainMemory.InvalidAddressException {
          byte[] bytes = {00, 00, 00 ,00};
          try {
               memory.set(0,bytes);
          } catch (AbstractMainMemory.InvalidAddressException e) {
               fail();
          }
          byte[] result = new byte[4];
          try {
               result = memory.get(0, 4);
          } catch (AbstractMainMemory.InvalidAddressException e) {
               fail();
          }
          assertArrayEquals(result, bytes);
     }

     @Test
     public void testGetNegAddress() throws AbstractMainMemory.InvalidAddressException {
          byte[] bytes = {00, 00, 00 ,00};
          try {
               memory.set(0,bytes);
          } catch (AbstractMainMemory.InvalidAddressException e) {
               fail();
          }
          byte[] result = new byte[4];
          try {
               result = memory.get(-1, 4);
               fail("Exception should have been thrown");
          } catch (AbstractMainMemory.InvalidAddressException e) {
               e.printStackTrace();
          }
          assertArrayEquals(result, bytes);
     }

     @Test
     public void testGetTooLong() throws AbstractMainMemory.InvalidAddressException {
          byte[] bytes = {00, 00, 00 ,00};
          try {
               memory.set(0,bytes);
          } catch (AbstractMainMemory.InvalidAddressException e) {
               fail();
          }
          byte[] result = new byte[4];
          try {
               result = memory.get(4, 16);
               fail("Exception should have been thrown");
          } catch (AbstractMainMemory.InvalidAddressException e) {
               e.printStackTrace();
          }
          assertArrayEquals(result, bytes);
     }

     @Test
     public void testGetNotAligned() throws AbstractMainMemory.InvalidAddressException {
          byte[] bytes = {00, 00, 00 ,00};
          try {
               memory.set(0,bytes);
          } catch (AbstractMainMemory.InvalidAddressException e) {
               fail();
          }
          byte[] result = new byte[4];
          try {
               result = memory.get(3, 4);
               fail("Exception should have been thrown");
          } catch (AbstractMainMemory.InvalidAddressException e) {
               e.printStackTrace();
          }
          assertArrayEquals(result, bytes);
     }
}